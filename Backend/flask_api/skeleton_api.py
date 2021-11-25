from flask import Flask, session, request, jsonify
from scrape import *
import nltk
import ssl
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from summarize_text import *
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

# @app.route("/product/summarize", methods=["GET"])
# def get_product_summary():
#     if "summaries" in request.form:
#         total_summary = ""
#         for summary in request.form["summaries"]:
#             total_summary += summary

#         return jsonify(generate_summary(total_summary))
#     else:
#         return "Cant find form"


# @app.route("/product/sentiment", methods=["GET"])
# def get_product_sentiment():
#     if "summaries" in request.form:
#         sentiments = []
#         summaries = request.form["summaries"]
#         for summary in summaries:
#             sentiments.append(analyzer.polarity_scores(summary)["compound"])
#         print(sentiments)
#         return jsonify(sum(sentiments) / len(sentiments))
#     else:
#         return "Cant find form"


### AMAZON ROUTES ###
@app.route("/amazon/information", methods=["POST"])
def get_amazon_product_content():
    if "product_asin" in request.json:
        ret = {}
        content = getProductContent(request.json["product_asin"])
        # return jsonify(**ret)
        sentiments = []
        total_summary = ""
        for summary in content:
            #for rev in content[summary]:
                #sentiments.append(analyzer.polarity_scores(rev)["compound"])
               # total_summary += rev
            ret["name"] = summary
        #ret["sentiment"] = str(sum(sentiments) / len(sentiments))
        ret["summary"] = generate_summary(total_summary)

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
