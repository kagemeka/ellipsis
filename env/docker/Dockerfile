ARG ALPINE_VERSION=latest


FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04 AS on-gpu
LABEL com.kagemeka.gpu=true
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root/
# ENV CUDA_VISIBLE_DEVICES=0 
RUN ln -snf \
    /usr/share/zoneinfo/$TZ \
    /etc/localtime \
    && echo $TZ > /etc/timezone
    # && apt --quiet=2 update \
    # && apt --yes --quiet=2 upgrade \
    # && apt --yes --quiet=2 --no-install-recommends install \
    # libcudnn8 \
    # libcudnn8-dev



FROM alpine:${ALPINE_VERSION} AS builder   
COPY requirements.txt /root/ 


FROM on-gpu AS base-stage
SHELL ["/bin/bash", "-c"]
LABEL com.kagemeka.author=kagemeka
ENV DEBIAN_FRONTEND=noninteractive 
ENV DOCKER_BUILDKIT=1 \
    COMPOSE_DOCKER_CLI_BUILD=1 \
    DISPLAY=$DISPLAY \
    TZ=Asia/Tokyo \
    SDL_AUDIODRIVER=dsp


ARG github_access_token
COPY requirements.txt /root/ 
WORKDIR /root/
RUN ln -snf \
    /usr/share/zoneinfo/$TZ \
    /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apt -q=2 update \
    && apt -yq=2 upgrade \
    && apt -yq=2 install \
    apt-file \
    apt-transport-https \
    apt-utils \
    binutils \
    build-essential \
    cloc \
    cmake \
    curl \
    default-jdk \
    default-jre \
    default-libmysqlclient-dev \
    ffmpeg \
    file \
    firefox \
    git \
    graphviz \
    iproute2 \
    iputils-ping \
    lame \
    libc6-dev \
    libcurl4 \
    libedit2 \
    libedit-dev \
    libgcc-9-dev \
    libgtk2.0-dev \
    libmecab-dev \
    libmysqlclient-dev \
    libopencv-dev \
    libpq-dev \
    libpython2.7 \
    librdkit1 \
    libsm6 \
    libsqlite3-0 \
    libsqlite3-dev \
    libstdc++-9-dev \
    libxext6 \
    libxml2 \
    libz3-dev \
    locales \
    make \
    mecab \
    mecab-ipadic-utf8 \
    mysql-client \
    mysql-server \
    neovim \
    netcat \
    net-tools \
    openssh-server \
    pkg-config \
    python3-dev \
    python3-neovim \
    python3-opencv \
    python3-opengl \
    python3-pip \
    python3-rdkit \
    python3-tk \
    qt5-default \
    rdkit-data \
    snapd \
    software-properties-common \
    ssh \
    sudo \
    tesseract-ocr \
    tree \
    tzdata \
    ubuntu-drivers-common \
    unzip \
    vim \
    wget \
    xauth \
    xclip \
    xvfb \
    x11-utils \
    zip \
    zlib1g-dev \
    && apt-file update \
    && rm -rf /var/lib/apt/lists/* \
    && apt --yes clean \
    && git clone \
    https://${github_access_token}@github.com/kagemeka/.ssh.git \
    && chmod 400 -R .ssh \
    && git config --global user.email kagemeka1@gmail.com \
    && git config --global user.name kagemeka \
    && echo "PS1='\W '" >> ~/.bashrc \
    && echo "bind '\"\t\":menu-complete'" >> ~/.bashrc \
    && apt update 



FROM base-stage AS python-stage
COPY --from=builder /root/requirements.txt /root/



FROM ubuntu:20.04 AS mecab-stage
RUN \
    git clone --depth 1 \
    https://github.com/neologd/mecab-ipadic-neologd.git \
    && echo yes | \
    ./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n \
    && rm -r mecab-ipadic-neologd


FROM python-stage AS golang-stage


FROM golang-stage AS node-js-stage


FROM node-js-stage AS julia-stage


FROM julia-stage AS kotlin-stage 
WORKDIR /root/
RUN apt --quiet=2 update \
    && curl -s https://get.sdkman.io | bash \
    && source .sdkman/bin/sdkman-init.sh \
    && sdk install kotlin 


FROM kotlin-stage AS dart-stage 



FROM dart-stage AS rust-stage



FROM rust-stage AS c-sharp-stage


FROM c-sharp-stage AS swift-stage



FROM swift-stage AS chrome-stage
WORKDIR /root/
RUN apt --quiet=2 update \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt --yes install \
    ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb 



FROM chrome-stage AS firefox-stage
ARG VER=0.29.0
WORKDIR /root/
RUN apt -q=2 update \
    && wget https://github.com/mozilla/geckodriver/releases/download/v$VER/geckodriver-v$VER-linux64.tar.gz \
    && tar -C /usr/bin/ \
    -xvzf geckodriver*.tar.gz \
    && rm geckodriver* \
    && chmod +x /usr/bin/geckodriver


FROM firefox-stage AS artifact

HEALTHCHECK CMD echo "Are you healthy?" || exit 1

WORKDIR /root/
# ENTRYPOINT ["echo", "Hello, "]
# CMD ["This is \"All in ONE\" Container."]

ONBUILD COPY requirements.txt /root/
ONBUILD RUN pip install --requirement requirements.txt

EXPOSE 8888 8080

FROM artifact as product 
RUN echo "This is multi-stage build!"
WORKDIR /root/
# ENTRYPOINT [ "/bin/bash" ]
# CMD [""]