FROM caddy:2.5.2-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/pteich/caddy-tlsconsul \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.5.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Override the entrypoint with a bash script which handles SIGHUP and triggers reload
RUN apk add --no-cache tini
COPY signal-handler.sh /
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/signal-handler.sh", "caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
