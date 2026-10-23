FROM alpine:latest@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a AS builder

ARG VERSION

RUN apk add --update curl
RUN curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
    && mkdir /phanpy \
    && tar zxf phanpy-dist.tar.gz -C /phanpy

FROM nginx:stable-alpine-slim@sha256:d9322bba63c6cfc63dc9e86522fd4f95fd4d9020a02b5bced282bbf38b8c3960

LABEL org.opencontainers.image.source=https://github.com/coxde/phanpy-docker
LABEL org.opencontainers.image.description="Unofficial Image for Phanpy"
LABEL org.opencontainers.image.licenses=MIT

COPY --from=builder /phanpy /usr/share/nginx/html
