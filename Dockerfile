FROM debian:jessie

WORKDIR /opt

# Create directories for the config files
RUN mkdir -p /opt/tor /opt/privoxy

# Add the tor repository to the sources lists
ADD ./tor/tor.list /etc/apt/sources.list.d/tor.list

# Add the config files to the container
ADD ./privoxy/config /opt/privoxy/config
ADD ./tor/torrc /opt/tor/torrc

# Retrieve signing key for Tor packages
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

# Update and install the required tools
RUN apt-get update && apt-get install -y privoxy tor deb.torproject.org-keyring

# Run Tor and Privoxy
CMD tor -f /opt/tor/torrc && privoxy --no-daemon /opt/privoxy/config


