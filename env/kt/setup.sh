#!/bin/bash

apt -q=2 update \
&& apt install -yq=2 \
apt-utils \
default-jre

apt install -yq=2 \
curl \
unzip \
zip \
&& curl -s https://get.sdkman.io | bash \
&& echo \
'source $HOME/.sdkman/bin/sdkman-init.sh' \
>> ~/.bashrc \
&& source ~/.bashrc \
&& source $HOME/.sdkman/bin/sdkman-init.sh \
&& sdk install kotlin 