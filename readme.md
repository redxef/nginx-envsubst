# nginx-envsubst

A simple docker image for configuring nginx with environment variables.

## Usage
This image does not ship with a default configuration.
To get started place your nginx config in `/etc/nginx/nginx.conf`
and your normal server configurations in `/etc/nginx/sites-enabled/`.

Every configuration file in `/etc/nginx/sites-available/` will get
passed to `envsubst` and written to `/etc/nginx/sites-enabled/`.

To specify which variables to substitute place a file
`/environment_variables.txt` in the docker container with all variables
which should be passed to envsubst.

## Minimal Example

```sh
docker run \
    -v "$PWD/nginx.conf":/etc/nginx/nginx.conf \
    -v "$PWD/server.conf":/etc/nginx/sites-available/server.conf \
    -v "$PWD/index.html":/var/www/html/index.html \
    -e DOMAIN_NAME=localhost -p 80:80 \
    redxef/nginx-envsubst:latest
```
