FROM alpine:latest@sha256:c6b073f8e9e58d881f6ffba6ebf3b9ebd60b9e7d6e8337018c0e68bb5c356873 AS builder

ARG VERSION

RUN apk add --update curl
RUN curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
    && mkdir /phanpy \
    && tar zxf phanpy-dist.tar.gz -C /phanpy

FROM nginx:stable-alpine-slim@sha256:a6cc4968d63e87b7d78fb0e089dcd85a6c88e7660b9b06ee0c9b380ac7bc5593

LABEL org.opencontainers.image.source=https://github.com/coxde/phanpy-docker
LABEL org.opencontainers.image.description="Unofficial Image for Phanpy"
LABEL org.opencontainers.image.licenses=MIT

COPY --from=builder /phanpy /usr/share/nginx/html
