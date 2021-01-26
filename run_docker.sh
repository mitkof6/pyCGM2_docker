#!/usr/bin/env bash

# terminate if there is error
set -xeuo pipefail

# build docker
docker build -t pycgm2 .

# grant access to ${HOME}/.Xauthority: to docker's user /home/user/.Xauthority
#
# https://nelkinda.com/blog/xeyes-in-docker/
setfacl -m user:1000:r ${HOME}/.Xauthority

# run docker by mapping current .Xauthority to enable X
docker run \
    -it \
    --rm \
    --name pycgm2 \
    --net=host \
    -e DISPLAY \
    -v ${HOME}/.Xauthority:/home/user/.Xauthority \
    pycgm2 \
    "$@"
