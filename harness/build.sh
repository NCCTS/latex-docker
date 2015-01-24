#!/bin/bash

script_path () {
    local scr_path=""
    local dir_path=""
    local sym_path=""
    # get (in a portable manner) the absolute path of the current script
    scr_path=$(cd -P -- "$(dirname -- "$0")" && pwd -P) && scr_path=$scr_path/$(basename -- "$0")
    # if the path is a symlink resolve it recursively
    while [ -h $scr_path ]; do
        # 1) cd to directory of the symlink
        # 2) cd to the directory of where the symlink points
        # 3) get the pwd
        # 4) append the basename
        dir_path=$(dirname -- "$scr_path")
        sym_path=$(readlink $scr_path)
        scr_path=$(cd $dir_path && cd $(dirname -- "$sym_path") && pwd)/$(basename -- "$sym_path")
    done
    echo $scr_path
}

script_dir=$(dirname -- "$(script_path)")
cd $script_dir/..

quad_rand () {
    echo $RANDOM"-"$RANDOM"-"$RANDOM"-"$RANDOM
}

# Assumes boot2docker on a Mac with default '/Users/...' mount config
data_name=data-$(quad_rand)
docker run \
       -it \
       --name $data_name \
       -v $(pwd):/home/sailor/latex-docker \
       nccts/baseimage \
       /bin/true

mirr_name=mirr-$(quad_rand)
docker run \
       -d \
       --name $mirr_name \
       nccts/texlive-mirror \
       'while true; do sleep 86400; done'

builder_name=builder-$(quad_rand)
docker run \
       -it --rm \
       --env ENV_WHITE='*ALL*' \
       --link $mirr_name:mirr \
       --name $builder_name \
       -v /var/run:/var/docker_host/run \
       --volumes-from $data_name \
       nccts/builder \
       /home/sailor/latex-docker/harness/dind.sh

docker kill $mirr_name
docker rm $mirr_name
docker rm $data_name
