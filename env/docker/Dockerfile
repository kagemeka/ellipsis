ARG ALPINE_VERSION=latest
ARG github_access_token

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
    
ARG github_access_token=78dbf5e342d9fe8cfde8644f419f4ff4850a67de
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
    ffmpeg \
    file \
    firefox \
    git \
    gnupg2 \
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
WORKDIR /root/ 
ARG PYVER=3.9
RUN apt update \
    # && add-apt-repository \
    # ppa:deadsnakes/ppa \
    # && apt -q=2 update \
    # && apt install -y \
    # python${PYVER} \
    # python${PYVER}-distutils \
    # python${PYVER}-dev \
    # && rm /usr/bin/python3 \
    # && ln -s \
    # /usr/bin/python${PYVER} \
    # /usr/bin/python3 \
    # && curl \
    # https://bootstrap.pypa.io/get-pip.py \
    # -o get-pip.py \
    # && python3 get-pip.py
    && ln -sn \
    /usr/bin/python3 \
    /usr/bin/python \
    && pip3 install -U pip \
    && pip install \
    -Uqr requirements.txt \
    && rm requirements.txt \
    && git clone --depth 1 \
    https://github.com/neologd/mecab-ipadic-neologd.git \
    && echo yes | \
    ./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n \
    && rm -r mecab-ipadic-neologd


FROM python-stage AS golang-stage
ARG GO_VERSION=1.16.3
WORKDIR /root/
RUN apt --quiet=2 update \
    && wget -qO - \
    https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
    | tar -xzC /usr/local/ \
    && echo 'export GOPATH=/usr/local/go' >> ~/.bashrc \
    && source ~/.bashrc \
    && echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc \
    && echo "export GOPATH=$HOME/myenv/lib/go" >> ~/.bashrc


FROM golang-stage AS node-js-stage
WORKDIR /root/ 
RUN apt --quiet=2 update \
    && curl -sL https://deb.nodesource.com/setup_current.x \
    | sudo -E bash - \
    && apt install -y nodejs


FROM node-js-stage AS julia-stage
ARG JULIA_VERSION=1.6.0
WORKDIR /root/
RUN apt --quiet=2 update \
    && wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-$JULIA_VERSION-linux-x86_64.tar.gz \
    && tar -C /usr/local \
    -xvzf julia-$JULIA_VERSION-linux-x86_64.tar.gz \
    && ln -s /usr/local/julia-$JULIA_VERSION/bin/julia \
    /usr/bin/ \
    && rm julia-$JULIA_VERSION-linux-x86_64.tar.gz


FROM julia-stage AS kotlin-stage 
WORKDIR /root/
RUN apt --quiet=2 update \
    && curl -s https://get.sdkman.io | bash \
    && source .sdkman/bin/sdkman-init.sh \
    && sdk install kotlin 


FROM kotlin-stage AS dart-stage 
WORKDIR /root/ 
RUN apt --quiet=2 update \
    && wget -qO- \
    https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | apt-key add - \
    && wget -qO- \
    https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list \
    > /etc/apt/sources.list.d/dart_stable.list \
    && apt --quiet=2 update \
    && apt --yes --quiet=2 install dart \
    && echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.bashrc



FROM dart-stage AS rust-stage
WORKDIR /root/ 
RUN apt --quiet=2 update \
    && curl --proto '=https' --tlsv1.2 -sSf \
    https://sh.rustup.rs \
    | sh -s -- -y \
    && echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc 


FROM rust-stage AS c-sharp-stage
WORKDIR /root/ 
RUN apt --quiet=2 update \
    && wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt --quiet=2 update \
    && apt install --yes --quiet dotnet-sdk-3.1
ENV RUST_BACKTRACE=full


FROM c-sharp-stage AS swift-stage
ARG SWIFT_VER=5.3.3
ARG TOOLCHAIN_VER=2021-02-02-a
WORKDIR /root/ 
RUN apt -q=2 update \
    && wget -qO - \
    https://swift.org/builds/swift-${SWIFT_VER}-release/ubuntu2004/swift-${SWIFT_VER}-RELEASE/swift-${SWIFT_VER}-RELEASE-ubuntu20.04.tar.gz \
    | tar -xzC /usr/local/ \
    --transform=s/-${SWIFT_VER}-RELEASE-ubuntu20.04// \
    && echo 'export "PATH=/usr/local/swift/usr/bin:$PATH"' \
    >> ~/.bashrc \
    && wget -qO - \
    https://swift.org/builds/development/ubuntu2004/swift-DEVELOPMENT-SNAPSHOT-${TOOLCHAIN_VER}/swift-DEVELOPMENT-SNAPSHOT-${TOOLCHAIN_VER}-ubuntu20.04.tar.gz \
    | tar -xzC /usr/local/ \
    --transform=s/DEVELOPMENT-SNAPSHOT-${TOOLCHAIN_VER}-ubuntu20.04/toolchain/ \
    && echo 'export "PATH=/usr/local/swift-toolchain/usr/bin:$PATH"' \
    >> ~/.bashrc \
    && source ~/.bashrc \
    && git clone https://github.com/apple/sourcekit-lsp.git \
    && cd sourcekit-lsp \
    # && swift package update \
    # && swift build \
    # -Xcxx -I/usr/local/swift-toolchain/usr/lib/swift \
    # -Xcxx -I/usr/local/swift-toolchain/usr/lib/swift/Block \
    && cd Editors/vscode \
    && npm run createDevPackage

ENV SOURCEKIT_TOOLCHAIN_PATH=/usr/local/swift-toolchain
# must update toolchain(snapshot) regularly.
# additional settings are required (on README)



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
    -xvzf geckodriver* \
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