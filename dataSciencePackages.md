# Data Science Packages to be used in Pythonn

## Sentiment Analysis 
### [NLTK Vader](https://www.codeproject.com/Articles/5269445/Using-Pre-trained-VADER-Models-for-NLTK-Sentiment) 
- Decent accuracy with decent speed
- Returns sentiment score between [-1,1] - will have to normalize it between [0,1]
```python
text     # Output: 'This is cool!'

# If you haven’t already, download the lexicon
nltk.download('vader_lexicon')

# Initialize the VADER sentiment analyzer
from nltk.sentiment.vader import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()
sentiment = analyzer.polarity_scores(text)

# Output: {'neg': 0.0, 'neu': 0.436, 'pos': 0.564, 'compound': 0.3802}
# Take the compound and normalize it
sentiment = (sentiment['compound'] + 1 / 2)
```


## Text Summarization 
### [NLTK Text Rank through Graph Creation](https://github.com/edubey/text-summarizer/blob/master/text-summarizer.py) 
- Does not need huge overhead of pretrained model
- Textrank is a graph algorithm that summarizes text
- Finds the top_n sentances and combines them together 
```python
def generate_summary(file_name, top_n=5):
    nltk.download("stopwords")
    stop_words = stopwords.words('english')
    summarize_text = []

    # Step 1 - Read text anc split it
    sentences =  read_article(file_name)

    # Step 2 - Generate Similary Martix across sentences
    sentence_similarity_martix = build_similarity_matrix(sentences, stop_words)

    # Step 3 - Rank sentences in similarity martix
    sentence_similarity_graph = nx.from_numpy_array(sentence_similarity_martix)
    scores = nx.pagerank(sentence_similarity_graph)

    # Step 4 - Sort the rank and pick top sentences
    ranked_sentence = sorted(((scores[i],s) for i,s in enumerate(sentences)), reverse=True)    
    print("Indexes of top ranked_sentence order are ", ranked_sentence)    

    for i in range(top_n):
      summarize_text.append(" ".join(ranked_sentence[i][1]))

    # Step 5 - Offcourse, output the summarize text
    print("Summarize Text: \n", ". ".join(summarize_text))
```
