FROM alpine:3.6

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

ARG BRANCH=manyuser
ARG WORK=~


RUN apk --no-cache add python \
    libsodium \
    wget


RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz | tar -xzf - -C $WORK


WORKDIR $WORK/shadowsocksr-3.2.2

COPY shadowsocks.json /etc/shadowsocks.json

EXPOSE $SERVER_PORT
CMD python server.py -c /etc/shadowsocks.json
#CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS
