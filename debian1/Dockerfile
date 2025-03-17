FROM debian:stable

COPY ../otelcol-contrib.deb otelcol.deb
RUN dpkg -i otelcol.deb

COPY client.crt /client.crt
COPY client.key /client.key
COPY ca.crt /ca.crt

COPY fake_log.sh /fake_log.sh
RUN chmod 700 /fake_log.sh
CMD /fake_log.sh & /usr/bin/otelcol-contrib --config=/etc/otelcol/config.yaml
