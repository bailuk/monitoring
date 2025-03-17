FROM debian:stable

COPY otelcol-contrib.deb otelcol.deb
RUN dpkg -i otelcol.deb


COPY server.crt /server.crt
COPY server.key /server.key
COPY ca.crt /ca.crt

CMD ["/usr/bin/otelcol-contrib", "--config=/etc/otelcol/config.yaml"]
