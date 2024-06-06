import psycopg2
import json


def get_users():
    # Connect to your database
    conn = psycopg2.connect(
        dbname="your_db_name",
        user="your_db_user",
        password="your_db_password",
        host="your_db_host",
        port="your_db_port"
    )
    cursor = conn.cursor()
    query = "SELECT username, email, password_hash, salt FROM users"
    cursor.execute(query)
    users = cursor.fetchall()

    cursor.close()
    conn.close()

    keycloak_users = []
    for user in users:
        keycloak_user = {
            "username": user[0],
            "email": user[1],
            "enabled": True,
            "credentials": [
                {
                    "type": "password",
                    "value": user[2],
                    "algorithm": "pbkdf2-sha512",
                    "salt": user[3],
                    "hashIterations": 210000
                }
            ]
        }
        keycloak_users.append(keycloak_user)
        
    with open('keycloak_users.json', 'w') as f:
        json.dump(keycloak_users, f, indent=2)