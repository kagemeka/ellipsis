apt -q=2 update \
&& apt install -y \
apt-utils \
wget \ 
&& wget -qO - \
https://dl.google.com/go/go${GOVER}.linux-amd64.tar.gz \
| tar -xzC /usr/local/ \
&& echo 'export GOPATH=/usr/local/go' >> ~/.bashrc \
&& source ~/.bashrc \
&& echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc