# nginx-envsubst

A simple docker image for configuring nginx with environment variables.

## Usage
Mount you whole nginx configuration into `/etc/nginx.tmpl/`.
The configuration files can contain environment variables compatible
with `envsubst`, list these variables in a file `/etc/envsubst.conf`.
Additionally, the server gets reloaded when a update to one of the
referenced certificates happens.

## Minimal Example

```sh
cd example
docker run --rm -it \
    -e DOMAIN_NAME=localhost \
    -p 80:80 -p 443:443 \
    -v "$PWD/nginx.conf:/etc/nginx.tmpl/nginx.conf" \
    -v "$PWD/envsubst.conf:/etc/envsubst.conf" \
    -v "$PWD/cert:/cert" \
    redxef/nginx-envsubst
```

## Source

[gitea.redxef.at/redxef/nginx-envsubst](https://gitea.redxef.at/redxef/nginx-envsubst)
