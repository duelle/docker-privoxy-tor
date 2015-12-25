FROM debian:jessie

WORKDIR /opt

RUN apt-get update && apt-get install -y tor privoxy

ADD ./privoxy /opt/privoxy
ADD ./tor /opt/tor

CMD tor -f /opt/tor/torrc && privoxy --no-daemon /opt/privoxy/config


