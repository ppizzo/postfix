FROM debian:bullseye-slim

MAINTAINER "Pietro Pizzo <pietro.pizzo@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y postfix gettext-base && apt-get clean && rm -rf /var/cache/apt
WORKDIR /etc/postfix
COPY entrypoint.sh /
COPY main.cf.template .

ENTRYPOINT ["/entrypoint.sh"]
