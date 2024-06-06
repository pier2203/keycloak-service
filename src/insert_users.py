import requests

def insert_users():
    keycloak_url = "http://localhost:8080/auth"
    realm = "classic-eval"
    admin_username = "admin"
    admin_password = "admin"
    client_id = "admin-cli"

    token_url = f"{keycloak_url}/realms/{realm}/protocol/openid-connect/token"
    token_data = {
        "grant_type": "password",
        "client_id": client_id,
        "username": admin_username,
        "password": admin_password
    }
    token_response = requests.post(token_url, data=token_data)
    token_response.raise_for_status()
    access_token = token_response.json()['access_token']

    with open('keycloak_users.json', 'r') as f:
        users = json.load(f)

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {access_token}"
    }
    user_import_url = f"{keycloak_url}/admin/realms/{realm}/users"

    for user in users:
        response = requests.post(user_import_url, headers=headers, json=user)
        if response.status_code == 201:
            print(f"User {user['username']} imported successfully")
        else:
            print(f"Failed to import user {user['username']}: {response.text}")