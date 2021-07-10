#!/bin/bash

PYVER=3.9

apt -q=2 update \
&& apt -yq=2 upgrade \
&& apt install -yq=2 \
apt-utils \
cmake \
git \
libmysqlclient-dev \
libpq-dev \
software-properties-common \
&& apt-add-repository -y \
ppa:deadsnakes/ppa \
&& apt -q=2 update \
&& apt install -yq=2 \
python$PYVER \
python$PYVER-dev \
python$PYVER-distutils \
python3-opencv \
python3-pip \
python3-neovim \
tesseract-ocr \
&& ln -fns \
/usr/bin/python$PYVER \
/usr/bin/python3 \
&& pip install -Uq \
pip \
setuptools \
&& apt update -q=2