FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y git curl dos2unix && \
    apt-get clean

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && dos2unix /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
