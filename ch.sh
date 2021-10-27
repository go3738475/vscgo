#!/bin/bash

for i in $(docker images -q)
do
    docker history $i | grep -q dcf79059ae78 && echo $i
done | sort -u
