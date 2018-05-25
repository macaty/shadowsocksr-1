FROM alpine:3.6
MAINTAINER Xuhui <1498472791@qq.com> ref:breakwa11/shadowsocksr

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     80
ENV PASSWORD        cisco
ENV METHOD          chacha20
ENV PROTOCOL        auth_sha1_compatible
ENV PROTOCOLPARAM   32
ENV OBFS            http_simple_compatible
ENV TIMEOUT         300
ENV DNS_ADDR        114.114.114.114
ENV DNS_ADDR_2      223.5.5.5

ARG BRANCH=manyuser
ARG WORK=~


RUN apk --no-cache add python \
    build-base \
    git \
    gcc \
    openssl-dev \
    musl-dev \
    libsodium \
    wget \
    py2-pip \
    tzdata \
    python-dev \
    libevent-dev \
    py-setuptools \
    py2-gevent \
    --repository http://mirrors.ustc.edu.cn/alpine/v3.4/main/ --allow-untrusted && \
	pip install \
	M2Crypto

RUN mkdir -p $WORK && \
    cd ~ \
    git clone -b manyuser https://github.com/shadowsocksrr/shadowsocksr.git \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR $WORK/shadowsocks

RUN apk del \
        wget \
        tzdata && \
        rm -rf /tmp/* && rm -rf /var/cache/apk/* && rm -rf /var/lib/apk/*

EXPOSE $SERVER_PORT

CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM
