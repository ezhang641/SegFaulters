from flask import Flask, request, jsonify
from Backend.flask_api.scrape import *
from Backend.flask_api.sentiment import find_sentiment
import nltk
import ssl
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from Backend.flask_api.summarize_text import generate_summary
from Backend.flask_api.sentiment import *
from Backend.flask_api.pros_cons import make_pros_cons
from Backend.flask_api.abstractive_summary import summarize
import scipy as sp

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


#### USER ROUTES ####
# WILL BE IMPLEMENTED IN MVP

### PRODUCT ROUTES ###
@app.route("/product/information", methods=["GET"])
def get_product_information():
    pass

### AMAZON ROUTES ###
@app.route("/amazon/information", methods=["POST"])
def get_amazon_product_content():
    if "product_asin" in request.json:
        ret = {}
        content = getProductContent(request.json["product_asin"])
        sentiments = []
        total_summary = ""
        reviews_list = []
        for summary in content:
            for rev in content[summary]:
                sentiments.append(analyzer.polarity_scores(rev)["compound"])
                total_summary += rev
                reviews_list.append(rev)
            ret["name"] = summary
        # ret["sentiment"] = str(sum(sentiments) / len(sentiments))
        ret['sentiment'] = find_sentiment(total_summary)
        ret["summary"] = generate_summary(total_summary, top_n=5)
        pros, cons = make_pros_cons(reviews_list)
        ret["pros"] = pros
        ret["cons"] = cons
        ret["review1"] = content[ret["name"]][0]
        ret["review2"] = content[ret["name"]][1]

        return jsonify(**ret)
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