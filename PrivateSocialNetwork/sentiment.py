import nltk
import sys
import pickle
from nltk.tokenize import word_tokenize

word_features5k_f = open("C:\\Users\\user\\Desktop\\Sahridaya\\PrivateSocialNetwork\\word_features5k.pickle", "rb")
word_features = pickle.load(word_features5k_f)
word_features5k_f.close()


def find_features(document):
    words = word_tokenize(document)
    features = {}
    for w in word_features:
        features[w] = (w in words)

    return features
open_file = open("C:\\Users\\user\\Desktop\\Sahridaya\\PrivateSocialNetwork\\classifier_naivebayes5k.pickle", "rb")
classifier = pickle.load(open_file)
open_file.close()

##classifier.show_most_informative_features(200)

def sentiment(text):
    feats = find_features(text)
    return classifier.classify(feats)

text = sys.argv[1]
result = sentiment(text)
print(result)














    







    


        
    
    
