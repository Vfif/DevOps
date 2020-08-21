# import requests
#
# url = "http://www.stackoverflow.com"
# http_headers = {'Accept-Encoding': 'gzip'}
#
# response = requests.get(url, headers=http_headers)
# print(response.headers)
# print(response.headers['Content-Encoding'])
# f = open('text.txt', 'wb')
# f.write(response.content)
# f.close()

import gzip
import urllib.request

url = "http://www.stackoverflow.com"
http_headers = {'Accept-Encoding': 'gzip'}

request = urllib.request.Request(url, headers=http_headers)
response = urllib.request.urlopen(request)
result = gzip.decompress(response.read())
f = open('text.txt', 'wb')
f.write(result)
f.close()