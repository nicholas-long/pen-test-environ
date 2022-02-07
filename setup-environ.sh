#!/bin/bash

touch ~/.hushlogin

# set up git to store credentials
git config --global credential.helper store

git clone https://github.com/nicholas-long/setup-scripts
git clone https://github.com/nicholas-long/kb
#git clone https://github.com/nicholas-long/private
