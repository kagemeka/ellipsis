#!/bin/bash

apt update -q=2 \
&& apt install -yq=2 \
apt-utils \
curl \
sudo \
&& curl \
-sL https://deb.nodesource.com/setup_current.x \
| sudo -E bash - \
&& apt install -y nodejs