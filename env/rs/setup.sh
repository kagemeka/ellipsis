apt -q=2 update \
&& apt install -yq=2 \
apt-utils \
build-essential \
curl \
&& curl \
--proto '=https' \
--tlsv1.2 -sSf \
https://sh.rustup.rs \
| sh -s -- -y \
&& echo \
'export PATH="$HOME/.cargo/bin:$PATH"' \
>> ~/.bashrc 