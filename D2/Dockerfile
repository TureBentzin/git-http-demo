FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get clean

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
