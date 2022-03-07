FROM alpine:latest

RUN apk add --upgrade --no-cache nginx gettext inotify-tools \
 && mv /etc/nginx /etc/nginx.tmpl \
 && touch /etc/envsubst.conf

COPY start-nginx.sh /usr/local/bin/

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-nginx.sh"]
