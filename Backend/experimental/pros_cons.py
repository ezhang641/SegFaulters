import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer
# import required module
import sys
import ssl

# append the path of the
# parent directory
[sys.path.append(i) for i in ['.', '..']]
from Backend.flask_api.summarize_text import *
from Backend.experimental.new_summary import summarize

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
        condensed = generate_summary(review, top_n=1)
        # condensed = summarize(review)
        condensed = condensed.strip()
        if len(condensed.split(". ")[-1].split(" ")) < 5:
            condensed = ". ".join(condensed.split(". ")[:-1])

        if polarity_score > 0.4:
            pros.append((condensed, polarity_score))
        else:
            cons.append((condensed, polarity_score))

    pros, cons = sorted(pros, key=lambda x: x[1], reverse=True), sorted(cons, key=lambda x: x[1])
    return {"pros": [p[0] for p in pros], "cons": [p[0] for p in cons]}


reviews = ["Everyone is posting that there isn't a difference between these and the 1st gen.  This is misleading and inaccurate.  Is the improvement drastic, no, but it is still an improvement.  The improvement is that Apple has upgraded the on-board chip to the H1, which leads to faster and more stable pairing.  This isn't anecdotal.  It's been tested and proven to be faster.Also, if you opt for wireless charging, buy the case with the gen 2 AirPods and you'll save a few dollars.If you already have the 1st gen, then it's probably not worth the upgrade.  If you are looking to buy your first pair of AirPods, then go for these.", "These AirPods are amazing they automatically play audio as soon as you put them in your ears and pause when you take them out. A simple double-tap during music listening will skip forward. To adjust the volume, change the song, make a call, or even get directions, just say \"Hey Siri\" to activate your favorite personal assistant. Plus, when you're on a call or talking to Siri, an additional accelerometer works with dual beamforming microphones to filter out background noise and ensure that your voice is transmitted with clarity and consistency.Additionally, they deliver five hours of listening time on a single charge, and they're made to keep up with you thanks to a charging case that holds multiple additional charges for more than 24 hours of listening time. Just 15 minutes in the case gives you three hours of listening to time or up to two hours of talk time.I would highly recommend it to anyone looking to buy", "These are great but not much better then gen1. Only addition is Siri feature. I will rather buy the previous model on discount and Save some green.", "My son really wanted airpods but his parents thought that they were a waste of money so I bought them for him behind their back and he loves them!! He has wanted them for a while now and these are really good quality!! Real things!! He wore them all day long!! Glad he's thankful!! God Bless, Margaret (Michael's mother)", "I had the AirPods for only a few days.. every time I opened the charging case (after couple hours - enough time for charging), the left earplug was always at very low battery (0-5%), but the right one is fully charged. So I returned it.", "Excellent, pretty useful... easy to use and reliable. At first I had some doubts about it being reliable to my Mac as some Bluetooth speakers sometimes cut off, but these work great and are really comfortable to my ears. Aesthetically, they look great to me.Worth every penny.", "Poor quality microphone. Not suitable for a remote worker taking calls. If your job requires dictation or a high quality mic, go elsewhere", "Got it for my wife's birthday. Since XS doesn't have the old headphone plugs, AirPods work perfectly. More importantly she loves it. Sound effect is pretty good too.", "We bought a brand new set of AirPods for $159. After using them for a week, I was listening to them and the right air pod went dead. I figured, maybe I just need to charge them. So when I got home I charged them, and the next day I went to use them again and the right air bud was still dead. So I did some research, tried to reset them, and then I couldn't reconnect them to my phone at all.Once I contacted Apple, they tried to give us the run around. They wanted us to let them fully die, which makes sense, so we did that. Then, when they still didn't work we wanted to exchange the faulty pair for a new set (BECAUSE WE PAID 159 DOLLARS AND ONLY USED THEM FOR A WEEK). Keep in mind, they were taken care of, not dropped, no water damage, they were expensive so they were treated delicately.  Apple wanted a $180 deposit to get a new set, which is MORE THAN WHAT I ORIGINALLY PAID FOR.I decided to contact Amazon, and they suggested contacting Apple, but once I explained what was going, on Amazon offered to make things right and send out a replacement. Never had an issue with Amazon's customer service, but Apple was extremely disappointing. I won't purchase these again.", "They are amazing. It's as simple as just opening the case and you're in. Sound quality isn't the best for headphones at this same price but the convenience is where you will be satisfied."]

print(make_pros_cons(reviews=reviews))


