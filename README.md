# Unofficial Phanpy Docker Image

## Docker run

```bash
docker run docker pull ghcr.io/coxde/phanpy-docker:latest
```

## Docker Compose

```yaml
---
services:
  phanpy:
    image: ghcr.io/coxde/phanpy-docker:latest
    container_name: phanpy
    ports:
      - 8080:80
```

## An example on Docker Stack

```yaml
---
services:
  stable:
    image: ghcr.io/coxde/phanpy-docker:latest
    networks:
      - traefik-public
    ports:
      - 80
    deploy:
      labels:
        - "homepage.group=Social"
        - "homepage.icon=/icons/phanpy.png"
        - "homepage.name=Phanpy"
        - "homepage.href=https://phanpy.example.org/"
        - "homepage.description=Alternative Mastodon Web Client"

        - "traefik.enable=true"
        - "traefik.http.routers.phanpy-efertone-me.rule=Host(`phanpy.example.org`)"
        - "traefik.http.services.phanpy-efertone-me.loadbalancer.server.port=80"
        - "traefik.http.routers.phanpy-efertone-me.tls=true"
        - "traefik.http.routers.phanpy-efertone-me.tls.certresolver=cloudflare"
        - "traefik.http.routers.phanpy-efertone-me.entryPoints=http,https"
        - "traefik.docker.network=traefik-public"

networks:
  traefik-public:
    external: true
```
