FROM alpine:edge

ARG MPD_VERSION=0.23
ARG MPD_PATCH=12

RUN set -x \
  \
  && apk add --no-cache --virtual .build-deps \
    g++ \
    meson \
    py3-sphinx \
    lame-dev \
    glib-dev \
    curl-dev \
    libao-dev \
    libmad-dev \
    flac-dev \
    libogg-dev \
    faad2-dev \
    libid3tag-dev \
    libvorbis-dev \
    alsa-lib-dev \
    libsamplerate-dev \
    libshout-dev \
    libmodplug-dev \
    boost-dev \
    icu-dev \
    libnfs-dev \
    # samba-dev \
    # opus-dev \
    opus-tools \
    ffmpeg-dev \
    libmpdclient-dev \
    # libcdio-paranoia-dev \
    libcap \
    # gtest-dev \
    # gtest \
    libsndfile-dev \
    sqlite-dev \
    soxr-dev \
    bzip2-dev \
    libcdio-dev \
    zlib-dev \
    mpg123-dev \
    wavpack-dev \
    ca-certificates \
    wget \
  \
## build
  && mkdir -p /usr/src/mpd \
  && cd /usr/src/mpd \
  && wget -O mpd.tar.xz https://www.musicpd.org/download/mpd/$MPD_VERSION/mpd-$MPD_VERSION.$MPD_PATCH.tar.xz \
  && tar xf mpd.tar.xz --strip-components=1 -C /usr/src/mpd \
  && rm mpd.tar.xz \
  \
  && meson \
    --prefix=/usr/local \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --buildtype=plain \
    output \
  && ninja -C output install \
  \
## cleanup
  && rm -rf /usr/src \
  && runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
      | tr ',' '\n' \
      | sort -u \
      | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
  )" \
  && apk add --virtual .mpd-rundeps $runDeps \
  && apk del .build-deps wget \
  && adduser -DH mpd

COPY mpd.conf /etc/mpd.conf
COPY docker-entrypoint.sh /
EXPOSE 6600 8000
ENTRYPOINT ["/docker-entrypoint.sh"]
