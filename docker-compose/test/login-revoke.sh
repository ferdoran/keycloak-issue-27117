#!/bin/sh

URL=http://localhost:8080
REALM=master
USER=admin
PASSWORD=admin
CLIENT=account-console

while true
do
  RESPONSE=$(curl -s -w "\nHTTP_STATUS_CODE:%{http_code}" -X POST \
      -d "username=$USER" \
      -d "password=$PASSWORD" \
      -d "client_id=$CLIENT" \
      -d "grant_type=password" \
      -d "scope=openid profile" \
      "$URL/auth/realms/$REALM/protocol/openid-connect/token")

  STATUS_CODE=$(echo "$RESPONSE" | awk -F: '/HTTP_STATUS_CODE/{print $2}')
  RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')
  echo "Status Code: $STATUS_CODE"
  REFRESH_TOKEN=$(echo $RESPONSE_BODY|jq -r '.refresh_token')
  echo "Refresh Token: $REFRESH_TOKEN"

  for i in `seq 1 5`;
  do
      RESPONSE=$(curl -s -w "\nHTTP_STATUS_CODE:%{http_code}" -X POST \
            -d "client_id=$CLIENT" \
            -d "token=$REFRESH_TOKEN" \
            "$URL/auth/realms/$REALM/protocol/openid-connect/revoke")

        STATUS_CODE=$(echo "$RESPONSE" | awk -F: '/HTTP_STATUS_CODE/{print $2}')
        RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')
        echo "Revoke Response Body: $RESPONSE_BODY"
  done

  sleep 1
done
