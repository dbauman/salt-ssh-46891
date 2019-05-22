#!/bin/bash
set -e
set -u
/usr/sbin/sshd
${@+"${@}"}

