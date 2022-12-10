#Based on src https://github.com/Tob1asDocker/rpi-mpd/blob/master/alpine.Dockerfile
FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="MPD" \
    org.opencontainers.image.description="MPD - Music Player Daemon" \
    org.opencontainers.image.licenses="GPL-2.0" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${VCS_REF}" 

COPY mpd.conf /etc/mpd.conf.new
       
RUN set -eux ; \
    apk --no-cache add \
        mpd \
        opus-tools \
    ; \
    mkdir /var/lib/mpd/data ; \
    touch /var/lib/mpd/data/database \
        /var/lib/mpd/data/state \
        /var/lib/mpd/data/sticker.sql \
    ; \
    chown -R mpd /var/lib/mpd ; \
    cp /etc/mpd.conf /etc/mpd.conf.backup ; \
    mv /etc/mpd.conf.new /etc/mpd.conf ; \
    chown -R mpd /etc/mpd.con* ; \
    chown -R mpd /mpd/cache
        
VOLUME /var/lib/mpd
WORKDIR /var/lib/mpd
EXPOSE 6600 8000

CMD ["/usr/bin/mpd", "--no-daemon", "--stdout", "/etc/mpd.conf" "$@"]
