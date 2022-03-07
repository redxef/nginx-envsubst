#!/usr/bin/env sh

pids=""

run_prog() {
    "$@" &
    pids="$! $pids"
}

trap_sig() {
    printf '%s' "$pids" | while IFS= read -r pid; do
        echo "pid=$pid"
        kill -s $1 $pid
    done
}

trap 'trap_sig TERM' SIGTERM

srcdir=/etc/nginx.tmpl/
dstdir=/etc/nginx/

find "$srcdir" -type d | while read -r src_directory; do
    dst_directory="$(echo "$src_directory" | sed "s|^$srcdir|$dstdir|")"
    mkdir -p "$dst_directory"
done

find "$srcdir" -type f | while read -r src_file; do
    dst_file="$(echo "$src_file" | sed "s|^$srcdir|$dstdir|")"
    envsubst "$(cat /etc/envsubst.conf)" < "$src_file" > "$dst_file"
done


run_nginx() {
    find "$dstdir"
    nginx -g 'daemon off;'
}

run_inotifywait() {
    while find "$dstdir" -type f -exec \
        sed -En '/ssl_certificate/ s/^\s*ssl_certificate(_key)? (.*);.*$/\2/p' {} \; | sort | uniq | \
        inotifywait --fromfile=-; do
            nginx -s reload
    done
}

run_prog run_nginx
run_prog run_inotifywait
wait $pids
