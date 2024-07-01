from alpine:latest as builder

ARG VERSION

run apk add --update curl
run curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
  && mkdir /phanpy \
  && tar zxf phanpy-dist.tar.gz -C /phanpy

from nginx:mainline-alpine-slim

label org.opencontainers.image.source=https://github.com/coxde/phanpy-docker
label org.opencontainers.image.description="Unofficial Docker Image for Phanpy"
label org.opencontainers.image.licenses=MIT

copy --from=builder /phanpy /usr/share/nginx/html
