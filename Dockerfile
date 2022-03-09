FROM alpine:3.15

RUN apk add --upgrade --no-cache nginx gettext inotify-tools
RUN mv /etc/nginx /etc/nginx.tmpl
RUN touch /etc/envsubst.conf

COPY start-nginx.sh /usr/local/bin/

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-nginx.sh"]
