FROM caddy:2.7.2-builder-alpine AS builder
RUN xcaddy build \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.7.2-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
