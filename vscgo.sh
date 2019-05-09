#!/bin/sh

docker stop vscgo;
docker rm vscgo;
xhost local:root;

#--user $(id -u):$(id -g) \

docker run -d \
--rm \
--user $(id -u):$(id -g) \
-p 80:3000 \
-p 8000:8000 \
-v /home/dev/projects/go/auth:/tmp/go \
-v $(pwd)/home:/home/user \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY \
--device /dev/dri \
--name vscgo \
vscgo;