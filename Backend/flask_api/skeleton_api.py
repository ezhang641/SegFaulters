from flask import Flask, session, request
import nltk
# import ssl

# try:
#     _create_unverified_https_context = ssl._create_unverified_context
# except AttributeError:
#     pass
# else:
#     ssl._create_default_https_context = _create_unverified_https_context

# nltk.download('vader_lexicon')

from nltk.sentiment.vader import SentimentIntensityAnalyzer
# from flask_api.summarize_text import generate_summary
import flask_api

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

        return flask_api.summarize_text.generate_summary(summary)


@app.route("/product/sentiment", methods=["GET"])
def get_product_sentiment():
    if "summaries" in request.form:
        sentiments = []
        summaries = request.form["summaries"]
        for summary in summaries:
            sentiments.append(analyzer.polarity_scores(summary)["compound"])
        return sum(sentiments) / len(sentiments)


### AMAZON ROUTES ###
@app.route("/amazon/information", methods=["GET"])
def get_amazon_reviews():
    # get reviews from scrape
    pass

if __name__ == '__main__':
   app.run()