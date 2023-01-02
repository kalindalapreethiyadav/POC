import requests
response = requests.get("https://api.github.com/user")
print(response.json())
print(type(response.json()))
url_details = int(response.json())

for i in url_details:
    print(f"url of the loc {i['documentation_url']}\n")
