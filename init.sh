#!/bin/sh

otel_version="0.121.0"
otel_release="https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${otel_version}"

test -f debian1/otelcol-contrib.deb || wget ${otel_release}/otelcol-contrib_${otel_version}_linux_amd64.deb -O debian1/otelcol-contrib.deb
cp debian1/otelcol-contrib.deb debian2/otelcol-contrib.deb

touch debian2/out.json
touch logstash/out.json

mkdir -p loki/data
chmod a+w loki/data

mkdir -p grafana/data
chmod a+w grafana/data

openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 365 -out ca.crt -subj "/CN=OTel CA"
cp ca.crt debian1/
cp ca.crt debian2/

openssl genrsa -out debian1/client.key 4096
openssl req -new -key debian1/client.key -out debian1/client.csr -config debian1/openssl.conf
openssl x509 -req -in debian1/client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out debian1/client.crt -days 365 -sha256 -extfile debian1/openssl.conf -extensions v3_req

openssl genrsa -out debian2/server.key 4096
openssl req -new -key debian2/server.key -out debian2/server.csr -config debian2/openssl.conf
openssl x509 -req -in debian2/server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out debian2/server.crt -days 365 -sha256 -extfile debian2/openssl.conf -extensions v3_req