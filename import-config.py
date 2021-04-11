import sys
import requests
from keycloak import KeycloakOpenID
from keycloak import KeycloakAdmin

requests.packages.urllib3.disable_warnings(requests.packages.urllib3.exceptions.InsecureRequestWarning)
host = sys.argv[1]
print("[*] Enable 'Direct Access Grants' for the Client named 'apiman'...", end="", flush=True)
keycloak_admin = KeycloakAdmin(server_url=f"https://{host}/auth/", username="admin", password="admin123!", realm_name="apiman", verify=False)
cid = keycloak_admin.get_client_id(client_name="apiman")
response = keycloak_admin.update_client(client_id=cid, payload={"directAccessGrantsEnabled": True})
if len(response) == 0:
    print("OK")
else:
    print("KO!")
    print(response)
    sys.exit(-1)
print("[*] Get access token and refresh tokens...", end="", flush=True)
keycloak_openid = KeycloakOpenID(server_url=f"https://{host}/auth/", client_id="apiman", client_secret_key="password", realm_name="apiman", verify=False)
config_well_know = keycloak_openid.well_know()
token = keycloak_openid.token("admin", "admin123!")
if token["access_token"] is not None and token["refresh_token"] is not None:
    print("OK")
else:
    print("KO!")
    print(token)
    sys.exit(-2)
print("[*] Import APIMAN configuration...")
auth_header = f"Bearer {token['access_token']}"
response = requests.get(f"https://{host}/apiman/organizations/XLM", headers={"Authorization": auth_header}, verify=False)
if response.status_code != 200 and response.status_code != 404:
    print(f"API call error: {response.status_code}")
    sys.exit(-3)
elif response.status_code == 200:
    print("Configuration already imported!")
else:
    with open("api-manager-export.json", "r") as f:
        cfg = f.read()
    response = requests.post(f"https://{host}/apiman/system/import", data=cfg, headers={"Authorization": auth_header, "Content-Type": "application/json"}, verify=False)
    print(response.text)
# Logout
print("[*] Logout...", end="", flush=True)
keycloak_openid.logout(token["refresh_token"])
print("OK")
sys.exit(0)

