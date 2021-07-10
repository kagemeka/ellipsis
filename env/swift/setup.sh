#!/bin/bash

apt -q=2 update \
&& apt install -yq=2 \
curl \
git \
sudo \
&& curl \
-sL https://deb.nodesource.com/setup_current.x \
| sudo -E bash - \
&& apt install -y nodejs \
&& git clone https://github.com/apple/sourcekit-lsp.git \
&& cd sourcekit-lsp/Editors/vscode/ \
&& npm install \
&& npm run dev-package \
&& mv sourcekit-lsp-development.vsix /root/

cd /root/
rm -r sourcekit-lsp


SWIFT_VER=5.4.2

apt update -q=2 \
&& apt install -yq=2 \
apt-utils \
binutils \
git \
gnupg2 \
libc6-dev \
libcurl4 \
libedit2 \
libgcc-9-dev \
libpython2.7 \
libsqlite3-0 \
libstdc++-9-dev \
libxml2 \
libz3-dev \
pkg-config \
tzdata \
wget \
zlib1g-dev \
&& wget -O - \
https://swift.org/builds/swift-${SWIFT_VER}-release/ubuntu2004/swift-${SWIFT_VER}-RELEASE/swift-${SWIFT_VER}-RELEASE-ubuntu20.04.tar.gz \
| tar -xzC /usr/local/ \
--transform=s/-${SWIFT_VER}-RELEASE-ubuntu20.04// \
&& echo \
'export "PATH=/usr/local/swift/usr/bin:$PATH"' \
>> ~/.bashrc \
&& source ~/.bashrc