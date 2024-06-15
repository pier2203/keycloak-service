FROM quay.io/keycloak/keycloak:24.0.4

ENV KEYCLOAK_ADMIN=ce_master
ENV KEYCLOAK_ADMIN_PASSWORD="-3gyP&/OPDxR"
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=mariadb
ENV KC_DB_URL=jdbc:mariadb://maria/sec
ENV KC_DB_USERNAME=sec_user
ENV KC_DB_PASSWORD=sec_user
ENV KC_HOSTNAME=localhost
ENV KC_HTTPS_CERTIFICATE_FILE=/etc/x509/https/tls.crt
ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/etc/x509/https/tls.key
COPY themes /opt/keycloak/themes/

# Support BCrypt algorithm for passwords (Migration from MariaDB, to be removed ASAP)
COPY dep/keycloak-bcrypt-1.6.0.jar /opt/keycloak/providers
COPY certs/cert5.pem /etc/x509/https/tls.crt
COPY certs/privkey5.pem /etc/x509/https/tls.key

ADD classic-eval-realm.json /opt/keycloak/data/import/classic-eval-realm.json
RUN /opt/keycloak/bin/kc.sh import --dir=/opt/keycloak/data/import/ --override false --optimized; exit 0
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]

EXPOSE 8443