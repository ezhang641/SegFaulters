import text2emotion as te

import nltk
import ssl
import pickle
import re 
from collections import Counter
import os

try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    pass
else:
    ssl._create_default_https_context = _create_unverified_https_context

nltk.download('punkt')
nltk.download('wordnet')

def find_sentiment(text):
    # text = "This product was average. I thought it was just fine. I won't go out of my way to buy it again."

    #Call to the function
    # print(te.get_emotion(text))
    emotion_dict = te.get_emotion(text)

    # load the model from disk
    filename = str(os.getcwd()) + '/Backend/flask_api/finalized_model.sav'
    # filename = 'Backend/flask_api/finalized_model.sav'
    clf = pickle.load(open(filename, 'rb'))

    emoji_dict = {"joy":"😂", "fear":"😱", "anger":"😠", "sadness":"😢", "disgust":"😒", "shame":"😳", "guilt":"😳"}
   
    filename2 = str(os.getcwd()) + '/Backend/flask_api/vectorizer.pickle'

    vectorizer = pickle.load(open(filename2, 'rb'))

    features = create_feature(text, nrange=(1, 4))
    features = vectorizer.transform(features)
    prediction = clf.predict(features)[0]

    # print("prediction", prediction)
    # print(emotion_dict)
    
    return emotion_dict, prediction

def get_emoji(emotion_dict, prediction):
    high_key = max(emotion_dict, key=emotion_dict.get)

    emoji = ""

    if (emotion_dict[high_key] >= 0.4 or prediction == "joy"):
        emoji = "Happy"
        if emotion_dict[high_key] >= 0.4 and prediction == "joy":
            emoji = "Love"
    elif (((prediction == "anger" or prediction == "disgust") and (emotion_dict["Angry"] >= 0.2 or emotion_dict["Fear"] >= 0.2)) or emotion_dict["Angry"] >= 0.4):
        emoji = "Frustrated"
    elif (prediction == "sadness" or emotion_dict["Sad"] >= 0.3):
        emoji = "Sad"
    elif (emotion_dict["Surprise"] + emotion_dict["Fear"] <= 0.20):
        emoji = "Bored"

    if emoji == "":
        emoji = "Neutral"

    # print(emoji)
    return emoji



def create_feature(text, nrange=(1, 1)):
    text_features = [] 
    text = text.lower() 
    text_alphanum = re.sub('[^a-z0-9#]', ' ', text)
    for n in range(nrange[0], nrange[1]+1): 
        text_features += ngram(text_alphanum.split(), n)    
    text_punc = re.sub('[a-z0-9]', ' ', text)
    text_features += ngram(text_punc.split(), 1)
    return Counter(text_features)

def ngram(token, n): 
    output = []
    for i in range(n-1, len(token)): 
        ngram = ' '.join(token[i-n+1:i+1])
        output.append(ngram) 
    return output