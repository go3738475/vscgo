#!/bin/bash
set -e
set -o pipefail

export GOROOT=/usr/local/go;
export GOPATH=/tmp/go;
export PATH=/home/user/bin:$GOPATH/bin:$GOROOT/bin:$PATH;

if [ $(id -u) -eq 1000 ]
then
/usr/share/code/code
else
su user -p -c /usr/share/code/code
fi
