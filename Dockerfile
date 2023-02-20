FROM caddy:2.6.4-builder-alpine AS builder
RUN xcaddy build \
    --with github.com/pteich/caddy-tlsconsul \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.6.4-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
