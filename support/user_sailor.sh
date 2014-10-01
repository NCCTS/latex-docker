#!/bin/bash

# Assumes 'mirror.sh' has been run to completion on the docker host
cd /docker-build/texlive-mirror
./install-tl -profile /docker-build/support/texlive-installation.profile \
             -repository /docker-build/texlive-mirror

cat /docker-build/support/bashrc_append_sailor.txt >> $HOME/.bashrc
