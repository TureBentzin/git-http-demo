FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y git apache2 apache2-utils && \
    apt-get clean

RUN a2enmod cgi

# git-http-backend dir
RUN mkdir -p /srv/git

# Apache2 config
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
