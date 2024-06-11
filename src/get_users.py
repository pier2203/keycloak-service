import mariadb
import json


def get_users():
    print('Connecting DB')
    # Connect to your database
    conn = mariadb.connect(
        database="scraping2",
        user="root",
        password="488Pist@",
        host="127.0.0.1",
        port=3306
    )
    print('Getting cursor')
    cursor = conn.cursor()
    query = "SELECT username, email, password FROM users"
    print('Query')
    cursor.execute(query)
    users = cursor.fetchall()

    cursor.close()
    conn.close()
    print('Closed connection')
    keycloak_users = []
    for user in users:
        keycloak_user = {
            "username": user[0],
            "email": user[1],
            "enabled": True,
            "credentials": [
                {
                    "type": "password",
                    "hashedSaltedValue": user[2],
                    "algorithm": "bcrypt",
                    "hashIterations": 10
                }
            ]
        }
        keycloak_users.append(keycloak_user)
    print(keycloak_users)
    with open('keycloak_users.json', 'w') as f:
        json.dump(keycloak_users, f, indent=2)