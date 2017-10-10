FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git wget zlib1g-dev netcat host vim-common bsdmainutils &&\
  rm -rf /var/lib/apt/lists/*

ENV OPENSSL_VER openssl-1.0.2l
ENV TESTSSL_VER 2.9.5
RUN wget -O /tmp/${OPENSSL_VER}.tar.gz https://www.openssl.org/source/${OPENSSL_VER}.tar.gz &&\
  cd /tmp/ && tar zxvf ${OPENSSL_VER}.tar.gz &&\
  cd /tmp/${OPENSSL_VER} &&\
  ./config zlib &&\
  make &&\
  make test &&\
  mv /usr/bin/openssl /usr/bin/openssl.bak &&\
  make install &&\
  ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl &&\
  cd /tmp &&\
  rm -rf /tmp/${OPENSSL_VER}.tar.gz /tmp/${OPENSSL_VER}

RUN cd /opt &&\
  git clone --depth 1 --branch ${TESTSSL_VER} https://github.com/drwetter/testssl.sh.git

USER nobody
ENTRYPOINT ["/opt/testssl.sh/testssl.sh"]
CMD ["-h"]
