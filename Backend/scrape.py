import requests
import json
import pandas as pd
from bs4 import BeautifulSoup

header = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36'
}

cookie = {
    'cookie': 'aws-ubid-main=706-1660020-4545526; remember-account=false; regStatus=registered; awsc-color-theme=light; aws-userInfo-signed=eyJ0eXAiOiJKV1MiLCJrZXlSZWdpb24iOiJ1cy1lYXN0LTEiLCJhbGciOiJFUzM4NCIsImtpZCI6ImQ4NWNkZjU1LTcxNDEtNDE0NS04YTY3LTZjYTQyZTNiZTJjYyJ9.eyJzdWIiOiIiLCJzaWduaW5UeXBlIjoiUFVCTElDIiwiaXNzIjoiaHR0cDpcL1wvc2lnbmluLmF3cy5hbWF6b24uY29tXC9zaWduaW4iLCJrZXliYXNlIjoicHh1aktvcnlya2FZcXJMaTFuZW1lYlFBXC9cLzBXZ0ExREtCcEJ0V1ZyY0VFPSIsImFybiI6ImFybjphd3M6aWFtOjoxNDg5ODM4NzU5Mzc6cm9vdCIsInVzZXJuYW1lIjoiZXZ6aGFuZyJ9.32KGUt0oRo3I8BFHeSoG-LN7KV1WMop2zF-sr9xIBZtdmrraGq0m3RA2jDACt1Dy7gCWjtLKJMKhKuINBeTZ8vvRuSi57frT_XZhOp_oDq_WPqXSyCofBtxqzOPZHY0A; aws-userInfo=%7B%22arn%22%3A%22arn%3Aaws%3Aiam%3A%3A148983875937%3Aroot%22%2C%22alias%22%3A%22%22%2C%22username%22%3A%22evzhang%22%2C%22keybase%22%3A%22pxujKoryrkaYqrLi1nemebQA%2F%2F0WgA1DKBpBtWVrcEE%5Cu003d%22%2C%22issuer%22%3A%22http%3A%2F%2Fsignin.aws.amazon.com%2Fsignin%22%2C%22signinType%22%3A%22PUBLIC%22%7D; session-id=144-5940438-1147442; i18n-prefs=USD; ubid-main=132-5770039-7369739; lc-main=en_US; session-id-time=2082787201l; skin=noskin; session-token=J7x1xt7wgaDbB8cXhicAh8kaY9lerbiSbY89LnV1BCBUX57o6FoLubTf2cs77hsz3+h0mvkewdvhLcLouanLFpfQtsQ0X668h+1+2yELfPv1KwHlE2m++Plgu69F6Vz66pZvv9V4T7yiEL8pvviwwXtYptrtwMgWBkj9FTxNmUSCi+SkmQm04Wm11o5374dU; csm-hit=tb:s-1E0WP9C3REPNDCF843JJ|1635470774870&t:1635470779243&adb:adblk_no'
}

def getAmazonSearch(search_query):
    url = "https://www.amazon.com/s?k=" + search_query
    print(url)
    page = requests.get(url, cookies=cookie, headers=header)
    if page.status_code == 200:
        return page
    return "Error"


def searchAsin(asin):
    url = "https://www.amazon.com/dp/" + asin
    print(url)
    page = requests.get(url, cookies=cookie, headers=header)
    if page.status_code == 200:
        return page
    return "Error"


def searchReviews(review_link):
    url = "https://www.amazon.com" + review_link
    print(url)
    page = requests.get(url, cookies=cookie, headers=header)
    if page.status_code == 200:
        return page
    return "Error"


def getProductNames(search):
    data_asin = []
    response = getAmazonSearch(search)
    soup = BeautifulSoup(response.content, "html.parser")

    # Finds all products related to the search query
    for i in soup.findAll("div", {
        'class': "s-result-item s-asin sg-col-0-of-12 sg-col-16-of-20 sg-col s-widget-spacing-small sg-col-12-of-16"}):
        data_asin.append(i['data-asin'])
    print(data_asin)
    productNames = {}
    for i in range(len(data_asin)):
        if i > 2:
            break
        response = searchAsin(data_asin[i])
        print(response)
        soup = BeautifulSoup(response.content, "html.parser")
        productNames[soup.find("span", {'id': "productTitle"}).text.strip()] = data_asin[i]

    return productNames


def getProductContent(data_asin):
    # Get to review page
    response = searchAsin(data_asin)
    soup = BeautifulSoup(response.content, "html.parser")
    j = soup.find("a", {'data-hook': "see-all-reviews-link-foot"})
    link = j['href']

    # Grab product review content
    reviews = []
    productName = ''
    productList = {}
    # Range dictates number of review pages
    for k in range(1):
        response = searchReviews(link + '&pageNumber=' + str(k))
        soup = BeautifulSoup(response.text, "html.parser")

        # find product name
        productName = soup.find("a", {'data-hook': "product-link"}).text

        # find reviews
        for i in soup.findAll("span", {'data-hook': "review-body"}):
            # Filter review content
            if len(i.text) > 3 and "The media could not be loaded" not in i.text:
                reviews.append(i.text.strip())

    if productName != '':
        productList[productName.strip()] = reviews

    return productList


def main():
    search = 'airpods'
    productName = getProductNames(search)
    print(productName)

    productList = getProductContent(productName['Apple AirPods Pro'])
    print(productList)


if __name__ == "__main__":
    main()
