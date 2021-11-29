import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer
# import required module
import sys
import ssl

# append the path of the
# parent directory
[sys.path.append(i) for i in ['.', '..']]
from Backend.flask_api.summarize_text import *
from Backend.flask_api.abstractive_summary import summarize

try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    pass
else:
    ssl._create_default_https_context = _create_unverified_https_context

nltk.download('vader_lexicon')

analyzer = SentimentIntensityAnalyzer()

def make_pros_cons(reviews):
    pros = []
    cons = []
    for review in reviews:
        polarity_score = analyzer.polarity_scores(review)["compound"]
        # condensed = generate_summary(review, top_n=1)
        condensed = summarize(review)
        condensed = condensed.strip()
        if len(condensed.split(". ")[-1].split(" ")) < 5:
            condensed = ". ".join(condensed.split(". ")[:-1])

        if polarity_score > 0.4:
            pros.append((condensed, polarity_score))
        else:
            cons.append((condensed, polarity_score))

    pros, cons = sorted(pros, key=lambda x: x[1], reverse=True), sorted(cons, key=lambda x: x[1])
    return [p[0] for p in pros], [c[0] for c in cons]

