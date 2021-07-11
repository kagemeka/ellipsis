#!/bin/bash

apt update -q=2 \
&& apt install -yq=2 \
apt-utils \
wget \
&& wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
-O packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& apt -q=2 update \
&& apt install -yq=2 \
dotnet-sdk-3.1 \
&& dotnet tool install -g dotnet-script