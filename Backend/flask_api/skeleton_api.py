from flask import Flask, session, request, jsonify
from scrape import *
import nltk
import ssl
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from sentiment import *
from pros_cons import make_pros_cons
from abstractive_summary import summarize
from summarize_text import *
import scipy as sp
import psycopg2
try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    pass
else:
    ssl._create_default_https_context = _create_unverified_https_context

nltk.download('vader_lexicon')

analyzer = SentimentIntensityAnalyzer()

app = Flask(__name__)

@app.route("/")
def index():
    return "Index"

### PRODUCT ROUTES ###
@app.route("/product/information", methods=["GET"])
def get_product_information():
    pass

### AMAZON ROUTES ###
@app.route("/amazon/information", methods=["POST"])
def get_amazon_product_content():
    if "product_asin" in request.json:
        try:
            connection = psycopg2.connect(user="aroon", password="aroonsmells", host="127.0.0.1", port="5432", database="review")
            cursor = connection.cursor()
     
            cursor.execute("SELECT info FROM products WHERE id=%s", (request.json["product_asin"],))

            result = cursor.fetchone()
        
            if result == None:
                ret = {}
                content = getProductContent(request.json["product_asin"])
                sentiments = []
        
                emotion_dict = {
                    "Happy" : 0.0,
                    "Angry" : 0.0,
                    "Surprise" : 0.0,
                    "Sad" : 0.0,
                    "Fear" : 0.0
                }
                total_summary = ""
                reviews_list = []
                for summary in content:
                    if summary == 'image':
                        ret['image'] = content[summary]
                        continue
                    for rev in content[summary]:
                        reviews_list.append(rev)
                        total_summary += rev
                        dict, prediction = find_sentiment(rev)
                        sentiments.append(prediction)
                        for key, value in dict.items():
                            emotion_dict[key] += value
                    ret["name"] = summary
                for key, value in emotion_dict.items():
                    emotion_dict[key] = value / float(len(sentiments))
                ret['sentiment'] = get_emoji(emotion_dict, max(set(sentiments), key=sentiments.count))
                ret["summary"] = generate_summary(total_summary)
                pros, cons = make_pros_cons(reviews_list)
                #print(pros, cons)
                ret["pros"] = "*".join(pros)
                ret["cons"] = "*".join(cons)
                #ret["review1"] = content[ret["name"]][0]
                #ret["review2"] = content[ret["name"]][1]

                #connection = psycopg2.connect(user="aroon", password="aroonsmells", host="127.0.0.1", port="5432", database="review")
                #cursor = connection.cursor()
                sql = """ INSERT INTO products(id, info) VALUES(%s, %s);"""
                cursor.execute(sql, (request.json['product_asin'], json.dumps(ret),))
                connection.commit()          
                return jsonify(**ret)

            else:
                return jsonify(**result[0])
        except (Exception, psycopg2.Error) as error:
            print("Error while fetching data from PostgreSQL", error)
            return "Issue with Database"
    else:
        return "Cant find form"


@app.route("/amazon/getnames", methods=["POST"])
def get_amazon_names():
    print(request.data)
    if "name" in request.json:
        names = getProductNames(request.json["name"])
        return jsonify(names)
    else:
        return "Cant find form"

if __name__ == '__main__':
    app.run()
