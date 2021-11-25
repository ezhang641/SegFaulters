import requests
import time
import pickle
from selenium import webdriver
import json
import pandas as pd
from bs4 import BeautifulSoup
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

header = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36'
}

cookie = {
        'name': 'Test',
    'value': 'aws-ubid-main=706-1660020-4545526; remember-account=false; regStatus=registered; awsc-color-theme=light; session-id=144-5940438-1147442; i18n-prefs=USD; ubid-main=132-5770039-7369739; lc-main=en_US; session-id-time=2082787201l; aws_lang=en; aws-target-data=%7B%22support%22%3A%221%22%7D; AMCVS_7742037254C95E840A4C98A6%40AdobeOrg=1; aws-target-visitor-id=1636422698460-840686.34_0; AMCV_7742037254C95E840A4C98A6%40AdobeOrg=1585540135%7CMCIDTS%7C18941%7CMCMID%7C35176489570007573534291562115760219402%7CMCAAMLH-1637027498%7C7%7CMCAAMB-1637027498%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1636429898s%7CNONE%7CMCAID%7CNONE%7CvVersion%7C4.4.0; s_campaign=PS%7Cacquisition_US%7Cgoogle%7CACQ-P%7CPS-GO%7CBrand%7CSU%7CBusiness%20Productivity%7CChime%7CUS%7CEN%7CText%7CSitelink%7C%2Bamazon%20%2Bchime%7C293647564726%7CBusiness%20Productivity%7Cb%7CUS; s_cc=true; aws-mkto-trk=id%3A112-TZM-766%26token%3A_mch-aws.amazon.com-1636422698974-62937; s_sq=%5B%5BB%5D%5D; aws-userInfo-signed=eyJ0eXAiOiJKV1MiLCJrZXlSZWdpb24iOiJ1cy1lYXN0LTEiLCJhbGciOiJFUzM4NCIsImtpZCI6ImQ4NWNkZjU1LTcxNDEtNDE0NS04YTY3LTZjYTQyZTNiZTJjYyJ9.eyJzdWIiOiIiLCJzaWduaW5UeXBlIjoiUFVCTElDIiwiaXNzIjoiaHR0cDpcL1wvc2lnbmluLmF3cy5hbWF6b24uY29tXC9zaWduaW4iLCJrZXliYXNlIjoiakR5VE52OFMzWlprMGV3bmlTTGJicnhGN3hOelVmcDVEVkdXcHdwSXBJOD0iLCJhcm4iOiJhcm46YXdzOmlhbTo6MTQ4OTgzODc1OTM3OnJvb3QiLCJ1c2VybmFtZSI6ImV2emhhbmcifQ.8Y3XLsbHgz8F7jZoyPHoG0gRYkO0Yw2qltK6QQiL8ZtTo4ADK91Dd-3--S53eFDDUZODotxDvadixCjK2oguIZrTuaQWRYXaOM7od6zwOQNdWN_rdUAtfRk3vI9iRao_; aws-userInfo=%7B%22arn%22%3A%22arn%3Aaws%3Aiam%3A%3A148983875937%3Aroot%22%2C%22alias%22%3A%22%22%2C%22username%22%3A%22evzhang%22%2C%22keybase%22%3A%22jDyTNv8S3ZZk0ewniSLbbrxF7xNzUfp5DVGWpwpIpI8%5Cu003d%22%2C%22issuer%22%3A%22http%3A%2F%2Fsignin.aws.amazon.com%2Fsignin%22%2C%22signinType%22%3A%22PUBLIC%22%7D; session-token=K8/CTA7x9tdRhu7JFFNLKUXwvvrjDAyHkd8YNH3Uv8y5h/Ioes/Ojka/TIljREyCyKBKJpdC3aNBWPAjJ51hG2U0cTBLSu1rBI42iny7dGe/il1l8x3hj7j/jp8GiEMt1Xnx2zCC4oDjeJ1ndcV2ZnBqB0zAN9CdRfT113kB7G9Sf+QYvKB7ZyrOFVG2479R; skin=noskin'
}

options = webdriver.ChromeOptions()
options.add_argument('--incognito')
options.add_argument('--headless')
options.add_argument('--disable-extensions')
options.add_argument('start-maximized')
options.add_argument('disable-infobars')
options.add_argument('user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36')
browse = webdriver.Chrome(options=options, executable_path='/home/ubuntu/SegFaulters/Backend/flask_api/chromedriver')

def getAmazonSearch(search_query):
    url = "https://www.amazon.com/s?k=" + search_query
    print(url)
    # page = requests.get(url, cookies=cookie, headers=header)
    browse.get(url)
    page = browse.page_source
    time.sleep(1)
    if page != '':
        return page
    print("Error with request")
    exit(1)


def searchAsin(asin):
    url = "https://www.amazon.com/dp/" + asin
    print(url)
    # page = requests.get(url, cookies=cookie, headers=header)
    browse.get(url)
    #with open("cookie_file", "wb") as filehandler:
       # pickle.dump(browse.get_cookies(), filehandler)

    # cookies = pickle.load(open("cookie_file", "rb"))

    #for i in cookies:
       # browse.add_cookie(i)
       # print('here')
    time.sleep(2)
    page = browse.page_source
    if page != '':
        return page
    print("Error with request")
    exit(1)


def searchReviews(review_link):
    url = "https://www.amazon.com" + review_link
    print(url)
    # page = requests.get(url, cookies=cookie, headers=header)
    browse.get(url)
    page = browse.page_source
    # print(page)
    print("Got reviews html page")
    if page != '':
        return page
    print("Error with request")
    exit(1)


def getProductNames(search):
    data_asin = []
    response = getAmazonSearch(search)
    soup = BeautifulSoup(response, "html.parser")

    # Finds all products related to the search query
    for i in soup.findAll("div", {
        'class': "s-result-item s-asin sg-col-0-of-12 sg-col-16-of-20 sg-col s-widget-spacing-small sg-col-12-of-16"}):
        data_asin.append(i['data-asin'])

    if (len(data_asin) == 0):
        for i in soup.findAll("div", {
        'class': "sg-col-4-of-12 s-result-item s-asin sg-col-4-of-16 sg-col s-widget-spacing-small sg-col-4-of-20"}):
            data_asin.append(i['data-asin'])

    print("data_asin")
    print(data_asin)
    productNames = {}
    for i in range(len(data_asin)):
        if i > 2:
            break
        response = searchAsin(data_asin[i])
        print("got response")
        soup = BeautifulSoup(response, "html.parser")
        productNames[soup.find("span", {'id': "productTitle"}).text.strip()] = data_asin[i]

    return productNames


def getProductContent(data_asin):
    # Get to review page
    response = searchAsin(data_asin)
    soup = BeautifulSoup(response, "html.parser")
    j = soup.find("a", {'data-hook': "see-all-reviews-link-foot"})
    link = j['href']

    # Grab product review content
    reviews = []
    productName = ''
    productList = {}
    # Range dictates number of review pages
    for k in range(1):
        response = searchReviews(link + '&pageNumber=' + str(k))
        soup = BeautifulSoup(response, "html.parser")

        # find product name
        productName = soup.find("a", {'data-hook': "product-link"}).text

        # find reviews
        for i in soup.findAll("span", {'data-hook': "review-body"}):
            # Filter review content
            if len(i.text) > 3 and "The media could not be loaded" not in i.text:
                reviews.append(i.text.strip())
        
    print(productName)
    if productName != '':
        productList[productName.strip()] = reviews

    return productList


def separateReviews(reviews):
    pos = []
    neg = []
    analyzer = SentimentIntensityAnalyzer()
    for review in reviews:
        # 0.4 is a common threshold for separating reviews
        if analyzer.polarity_scores(review)["compound"] > 0.4:
            pos.append(review)
        else:
            neg.append(review)

    return pos, neg


def main():
    search = 'airpods'
    productName = getProductNames(search)
    print(productName)

    productList = getProductContent(productName['New Apple AirPods Pro'])
    print(productList)


if __name__ == "__main__":
    main()
