# FROM nginx:alpine
FROM alpine:latest

RUN apk update && apk upgrade && apk add nginx gettext && \
    rm -r /etc/nginx

COPY start-nginx.sh /usr/local/bin/
COPY environment_variables.txt /

USER root
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["start-nginx.sh"]
