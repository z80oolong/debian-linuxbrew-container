#!/bin/sh
export DOCKER="/usr/bin/docker"
#export DOCKER="/usr/bin/podman"
${DOCKER} build -t z80oolong/debian-linuxbrew-container .
