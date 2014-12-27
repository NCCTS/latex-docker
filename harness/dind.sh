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
cp -R ../latex-docker ./
cd latex-docker
echo $mirr_http > support/repository.txt
build_tag=$(cat support/build_tag.txt)
echo -e "\nBuilding nccts/latex:$build_tag\n"
docker build -t nccts/latex:$build_tag .
