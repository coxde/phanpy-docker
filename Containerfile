FROM alpine:latest@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715 AS builder

ARG VERSION

RUN apk add --update curl
RUN curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
    && mkdir /phanpy \
    && tar zxf phanpy-dist.tar.gz -C /phanpy

FROM nginx:mainline-alpine-slim@sha256:94f1c83ea210e0568f87884517b4fe9a39c74b7677e0ad3de72700cfa3da7268

LABEL org.opencontainers.image.source=https://github.com/coxde/phanpy-docker
LABEL org.opencontainers.image.description="Unofficial Image for Phanpy"
LABEL org.opencontainers.image.licenses=MIT

COPY --from=builder /phanpy /usr/share/nginx/html
