ARG KEYCLOAK_VERSION=22.0.4

FROM quay.io/keycloak/keycloak:$KEYCLOAK_VERSION as builder

COPY keycloak.conf /opt/keycloak/conf/keycloak.conf
COPY cache-ispn-remote.xml /opt/keycloak/conf/cache-ispn-remote.xml

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:$KEYCLOAK_VERSION
COPY --from=builder /opt/ /opt/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]