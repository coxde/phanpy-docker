# Unofficial Phanpy Image

[Phanpy](https://github.com/cheeaun/phanpy) is a minimalistic opinionated Mastodon/Fediverse web client.

## Docker run

```bash
docker run ghcr.io/coxde/phanpy-docker:latest
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

## An example for Phanpy with Traefik (Docker)

```yaml
---
services:
  phanpy:
    image: ghcr.io/coxde/phanpy-docker:latest
    networks:
      - traefik-public
    ports:
      - 80
    deploy:
      labels:
        - "traefik.enable=true"
        - "traefik.http.routers.phanpy.rule=Host(`phanpy.example.org`)"
        - "traefik.http.routers.phanpy.entryPoints=websecure"
        - "traefik.http.routers.phanpy.tls=true"
        - "traefik.http.routers.phanpy.tls.certresolver=myresolver"
        - "traefik.http.services.phanpy.loadbalancer.server.port=80"

networks:
  traefik-public:
    external: true
```
## An example for Phanpy with Traefik (Podman)

```ini
[Container]
ContainerName=phanpy
Image=ghcr.io/coxde/phanpy-docker:latest
AutoUpdate=registry

NoNewPrivileges=true

Label=traefik.enable=true
Label=traefik.http.routers.phanpy.rule=Host(`phanpy.example.org`)
Label=traefik.http.routers.phanpy.entrypoints=websecure
Label=traefik.http.routers.phanpy.tls=true
Label=traefik.http.routers.phanpy.tls.certresolver=myresolver
Label=traefik.http.services.phanpy.loadbalancer.server.port=80

[Service]
Restart=always

[Install]
WantedBy=default.target
```
