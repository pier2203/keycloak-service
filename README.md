# Keycloak Service

### Features
* Authentication protocol: Oauth2
* Token standard: JWT
* User federation: Google, Facebook
* Database: MariaDB
* Custom login theme
* Custom realm (classic-eval-realm.json)

### External Dependency
* artifact: keycloak-bcrypt-1.6.0.jar
* why: old users are created with bcrypt algorithm,
keycloak does not have the built-in feature to decode 
those passwords, <b> however this dependency should be removed, 
and we need to reset the users passwords </b>