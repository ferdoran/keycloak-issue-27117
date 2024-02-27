ARG KEYCLOAK_VERSION=22.0.4

FROM quay.io/keycloak/keycloak:$KEYCLOAK_VERSION as builder

COPY config/keycloak-local-ispn.conf /opt/keycloak/conf/keycloak.conf
COPY config/cache-ispn-local.xml /opt/keycloak/conf/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:$KEYCLOAK_VERSION
COPY --from=builder /opt/ /opt/

# for remote debugging
# EXPOSE 8000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
