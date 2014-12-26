#!/bin/bash

cd /docker-build/support
repo=$(cat repository.txt)
wget $repo/install-tl-unx.tar.gz
tar xvzf install-tl-unx.tar.gz
cd $(dirname -- $(ls install-tl-*/install-tl))

./install-tl -profile /docker-build/support/texlive-installation.profile \
             -repository $repo

cat /docker-build/support/bashrc_append_sailor.txt >> $HOME/.bashrc
