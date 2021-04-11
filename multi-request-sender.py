import requests
import sys
from requests.auth import HTTPBasicAuth

# dependency: pip install requests
#       call: python multi-request-sender.py "https://localhost:8443/apiman-gateway/XLM/blog/1.2/todos/1?apikey=d09e70b2-2abc-47d8-9168-80878e662e6a" "user:password"
requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)
url = sys.argv[1]
authent = None
if len(sys.argv) == 3:
    creds = sys.argv[2].split(":")
    authent = HTTPBasicAuth(creds[0], creds[1])
with requests.Session() as s:
    s.auth = authent
    s.verify = False
    s.timeout = 20
    for i in range(0,20):
        response = s.get(url)
        if i == 19:
            print(f"[RC]:{response.status_code}")
            for h in response.headers:
                print(f"[{h}]:{response.headers[h]}")
            print(f"[BODY]:{response.text}")
sys.exit(0)


