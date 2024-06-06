FROM quay.io/keycloak/keycloak:24.0.4

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=mariadb
ENV KC_DB_URL=jdbc:mariadb://maria/sec
ENV KC_DB_USERNAME=sec_user
ENV KC_DB_PASSWORD=sec_user
ENV KC_HOSTNAME=localhost
#ENV KC_HTTPS_KEY_STORE_FILE=a
#ENV KC_HTTPS_KEY_STORE_PASSWORD=a
COPY themes /opt/keycloak/themes/

ADD classic-eval-realm.json /opt/keycloak/data/import/classic-eval-realm.json
RUN /opt/keycloak/bin/kc.sh import --dir=/opt/keycloak/data/import/ --override false --optimized; exit 0
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]

EXPOSE 8080 8443