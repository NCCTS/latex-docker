#!/bin/bash

mirr=($(echo $(echo $MIRR_PORT | tr 'tcp://' '\n')))
mirr_host=${mirr[0]}
mirr_port=${mirr[1]}
mirr_http=http://$mirr_host:$mirr_port/

# Wait for the mirror's port to open
while true; do
    nc $mirr_host $mirr_port < /dev/null
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 1
done

cd /home/sailor
mkdir temp
cd temp
git clone ../latex-docker
cd latex-docker
echo $mirr_http > support/repository.txt
docker build -t nccts/latex:0.0.10 .
