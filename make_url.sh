#!/bin/bash

set -euo pipefail

IFS= read -r password < passwd.txt

plug="djJyYXk="
plugdec=$(echo "$plug" | openssl enc -d -base64)

domain="${REPL_SLUG}.${REPL_OWNER}.repl.co"
plugin=$(echo -n "$plugdec;host=${domain};tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
ss="ss://$(echo -n chacha20-ietf-poly1305:${password} | base64 -w 0)@${domain}:443?plugin=${plugin}"

echo $(echo -n "$ss" | openssl enc -base64) > url.txt