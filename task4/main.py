import requests

url = "http://www.stackoverflow.com"
http_headers = {'Accept-Encoding': 'gzip'}

response = requests.get(url, headers=http_headers)
print(response.headers)
print(response.headers['Content-Encoding'])
# decompressed_data = zlib.decompress(response.content)
f = open('text.txt', 'wb')
f.write(response.content)
f.close()