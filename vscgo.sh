#!/bin/sh

#docker stop vscgo;
#docker rm vscgo;
xhost local:root;

#--user $(id -u):$(id -g) \
# USB
# --privileged
# -v /dev/bus/usb:/dev/bus/usb
# --security-opt=seccomp:unconfined \

# USB
# --privileged
# -v /dev/bus/usb:/dev/bus/usb


docker run -d \
--rm \
--security-opt=seccomp:unconfined \
--user $(id -u):$(id -g) \
-p 80:3000 \
-v /home/dev/projects/go/src:/tmp/go/src/github.com/go3738475 \
-v /home/dev/projects/go/bin:/tmp/go/bin \
-v /home/dev/projects/go/pkg:/tmp/go/pkg \
-v "/media/dev/7C023A99023A57FA/Users/user/Downloads/Blade Runner (1982) [2160p] [4K] [BluRay] [5.1] [YTS.MX]/:/tmp/v" \
-v $(pwd)/home:/home/user \
-v $(pwd)/start.sh:/usr/local/bin/start.sh \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY \
--device /dev/dri \
--device /dev/snd \
--name vscgo \
--ipc=host \
vscgo;
