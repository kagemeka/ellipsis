#!/bin/bash

MAJOR=1
MINOR=6
PATCH=1
MM_VER=${MAJOR}.${MINOR}
VER=${MM_VER}.${PATCH}
apt update -q=2 \
&& apt install -yq=2 \
apt-utils \
wget \
&& wget -O - \
https://julialang-s3.julialang.org/bin/linux/x64/${MM_VER}/julia-${VER}-linux-x86_64.tar.gz \
| tar \
-xvzC /usr/local \
--transform=s/-${VER}// \
&& ln -fns \
/usr/local/julia/bin/julia \
/usr/bin/julia