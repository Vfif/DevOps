import requests
# 'http://rentrip.herokuapp.com/'

response = requests.get(input())
print(response.status_code)
print(response.content)
