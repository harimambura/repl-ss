#!/bin/bash

set -euo pipefail

IFS= read -r password < passwd.txt
IFS= read -r url < url.txt

plug="djJyYXktcGx1Z2lu"
plugdec=$(echo "$plug" | openssl enc -d -base64)

exec go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:'"${password}"'@:8488' -plugin "$plugdec" -plugin-opts "server" -udp=false
echo "done"