
*** Update mpd to latest available, docker compose file included, DEFAULTS TO OPUS!***
## 
Add library auto-update, folder depth, symlink to config.
OpusTAGS enabled in stream (works for vlc and similar apps)
##

** Default configuration creates a *OPUS* stream over HTTP on port 8000

**Images**

```bash
docker pull ghcr.io/cornelcotoara/docker-mpd:master
```

#### Sample usage
**Docker** 

```bash
docker run -it --rm \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    ghcr.io/cornelcotoara/docker-mpd:master
```

**Docker Compose ghr.io**
```bash
version: '3.3'
services:
    mpd:
        hostname: mpd
        container_name: mpd
        volumes:
            - '/your_media/music/:/mpd/music' #add your personal settings
            - '/your_cache/cache:/mpd/cache'  #add your personal settings
        ports:
            - '6600:6600'
            - '8000:8000'
        image: 'ghcr.io/cornelcotoara/docker-mpd:master'
        restart: unless-stopped
```

**Docker Compose dockerhub**

```bash
version: '3.3'
services:
    mpd:
        hostname: mpd
        container_name: mpd
        volumes:
            - '/your_media/music/:/mpd/music' #add your personal settings
            - '/your_cache/cache:/mpd/cache'  #add your personal settings
        ports:
            - '6600:6600'
            - '8000:8000'
        image: 'ghcr.io/cornelcotoara/docker-mpd:master'
        restart: unless-stopped
```

**Podman**

```bash
podman run -it --rm \
    --security-opt label=disable \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    ghcr.io/cornelcotoara/docker-mpd:master
```

tMost kudos and my Thanks to @randomcoww
