from flask import Flask, session, request, jsonify
from Backend.flask_api.scrape import *
import nltk
import ssl
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from Backend.flask_api.summarize_text import *

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

@app.route("/product/summarize", methods=["GET"])
def get_product_summary():
    if "summaries" in request.form:
        total_summary = ""
        for summary in request.form["summaries"]:
            total_summary += summary

        return jsonify(generate_summary(total_summary))
    else:
        return "Cant find form"


@app.route("/product/sentiment", methods=["GET"])
def get_product_sentiment():
    if "summaries" in request.form:
        sentiments = []
        summaries = request.form["summaries"]
        # for summary in summaries:
        sentiments.append(analyzer.polarity_scores(summaries)["compound"])
        print(sentiments)
        return jsonify(sum(sentiments) / len(sentiments))
    else:
        return "Cant find form"


### AMAZON ROUTES ###
@app.route("/amazon/information", methods=["GET"])
def get_amazon_product_content():
    if "product_asin" in request.form:
        content = getProductContent(request.form["product_asin"])
        return jsonify(content)
    else:
        return "Cant find form"

@app.route("/amazon/getnames", methods=["GET"])
def get_amazon_names():
    if "name" in request.form:
        names = getProductNames(request.form["name"])
        return jsonify(names)
    else:
        return "Cant find form"

if __name__ == '__main__':
   app.run()