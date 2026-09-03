FROM alpine:latest@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder

ARG VERSION

RUN apk add --update curl
RUN curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
    && mkdir /phanpy \
    && tar zxf phanpy-dist.tar.gz -C /phanpy

FROM nginx:stable-alpine-slim@sha256:77da26c31397bf6694b4bf93275f5b40b0b120ba1b8f114264b603e592c561d6

LABEL org.opencontainers.image.source=https://github.com/coxde/phanpy-docker
LABEL org.opencontainers.image.description="Unofficial Image for Phanpy"
LABEL org.opencontainers.image.licenses=MIT

COPY --from=builder /phanpy /usr/share/nginx/html
