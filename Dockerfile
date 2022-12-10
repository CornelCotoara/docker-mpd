#Based on src https://github.com/Tob1asDocker/rpi-mpd/blob/master/alpine.Dockerfile
FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="MPD" \
    org.opencontainers.image.description="MPD - Music Player Daemon" \
    org.opencontainers.image.licenses="GPL-2.0" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${VCS_REF}" 

#COPY mpd.conf /etc/mpd.conf.new # provide your own an dmount as a file!

RUN set -x \
    apk --no-cache add \
        mpd \
        opus-tools \
    && adduser -DH mpd
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
