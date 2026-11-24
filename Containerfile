FROM alpine:latest@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS builder

ARG VERSION

RUN apk add --update curl
RUN curl -sLO "https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.tar.gz" \
    && mkdir /phanpy \
    && tar zxf phanpy-dist.tar.gz -C /phanpy

FROM nginx:stable-alpine-slim@sha256:8e907ab5bf2be45c22b6064ff1c3efa58c0269b76b578da342bb66c2cad81655

LABEL org.opencontainers.image.source=https://github.com/coxde/phanpy-docker
LABEL org.opencontainers.image.description="Unofficial Image for Phanpy"
LABEL org.opencontainers.image.licenses=MIT

COPY --from=builder /phanpy /usr/share/nginx/html
