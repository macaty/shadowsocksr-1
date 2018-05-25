FROM ubuntu:16.04


ARG shadowsocks_r_url="https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz"
ARG libsodium_url="https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz"

ENV conf=/etc/shadowsocks.json
ENV WORK=~

ENV libsodium_file="libsodium-1.0.16"
ENV libsodium_url="https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz"
ENV shadowsocks_r_file="shadowsocksr-3.2.2"
ENV shadowsocks_r_url="https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz"

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     80
ENV PASSWORD        cisco
ENV METHOD          chacha20
ENV PROTOCOL        auth_sha1_v4_compatible
ENV PROTOCOLPARAM   32
ENV OBFS            http_simple_compatible
ENV TIMEOUT         300
ENV DNS_ADDR        114.114.114.114
ENV DNS_ADDR_2      223.5.5.5



RUN apt-get update -y \
&& apt-get install -y \
python \
python-dev \
python-setuptools \
openssl \
libssl-dev \
curl \
wget \
unzip \
gcc \
automake \
autoconf \
make \
libtool \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p $WORK

RUN cd ${WORK} && wget --no-check-certificate -O ${libsodium_file}.tar.gz ${libsodium_url} && tar zxf ${libsodium_file}.tar.gz && cd ${libsodium_file} && ./configure --prefix=/usr && make && make install

RUN cd ${WORK} && wget --no-check-certificate -O ${shadowsocks_r_file}.tar.gz ${shadowsocks_r_url} && tar zxf ${shadowsocks_r_file}.tar.gz
	
WORKDIR $WORK/$shadowsocks_r_file

EXPOSE $SERVER_PORT

CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS
