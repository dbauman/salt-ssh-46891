#!/bin/bash
set -e
set -u

d="${HOME}/.ssh"
[[ -d "${d}" ]] || mkdir "${d}"
chmod 711 "${d}"
/usr/bin/ssh-keygen -t rsa -b 2048 -C "" -N "" -f "${d}/id_rsa"
