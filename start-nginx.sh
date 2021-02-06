#!/usr/bin/env sh

set -x

enable_server() {
    for name in "$@"; do
        src_dir="/etc/nginx/sites-available"
        dst_dir="/etc/nginx/sites-enabled"
        mkdir -p "$dst_dir"
        envsubst '${DOMAIN_NAME}' < "$src_dir/$name.conf" > "$dst_dir/$name.conf"
    done
}

enable_ssh_server() {
    for name in "$@"; do
        src_dir="/etc/nginx/ssh-available"
        dst_dir="/etc/nginx/ssh-enabled"
        mkdir -p "$dst_dir"
        envsubst '${DOMAIN_NAME}' < "$src_dir/$name.conf" > "$dst_dir/$name.conf"
    done
}

sub_env_vars="$(cat /environment_variables.txt)"

echo "Enabling servers"
(
    cd "/etc/nginx/sites-available" || exit $?
    test -d "../sites-enabled" || mkdir "../sites-enabled"
    for f in *.conf; do
        envsubst "$sub_env_vars" < "$f" > "../sites-enabled/$f"
    done
)

echo "Starting nginx"
exec nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
