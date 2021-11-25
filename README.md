
***Update mpd to latest available, docker compose file included!***

Kudos goes to:
### Docker MPD intended for HTTP streaming

#h??ps://hub.docker.com/r/randomcoww/mpd/

Default configuration creates a FLAC-3 stream over HTTP on port 8000

**Images**

https://hub.docker.com/repository/docker/b1trid3r/mpd

#### Sample usage
**Docker** 

```bash
docker run -it --rm \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    b1trid3r/mpd:v.0.23.4
```

**Podman**

```bash
podman run -it --rm \
    --security-opt label=disable \
    -v music_path:/mpd/music \
    -v cache_path:/mpd/cache \
    -p 6600:6600 \
    -p 8000:8000 \
    b1trid3r/mpd:v.0.23.4
```
