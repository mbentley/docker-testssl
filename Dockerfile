FROM stackbrew/debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential wget zlib1g-dev netcat host vim-common

ENV OPENSSL_VER openssl-1.0.1j
RUN (wget -O /tmp/${OPENSSL_VER}.tar.gz https://www.openssl.org/source/${OPENSSL_VER}.tar.gz &&\
	cd /tmp/ && tar zxvf ${OPENSSL_VER}.tar.gz &&\
	cd /tmp/${OPENSSL_VER} &&\
	./config zlib &&\
	make &&\
	make test &&\
	mv /usr/bin/openssl /usr/bin/openssl.bak &&\
	make install &&\
	ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl &&\
	cd /tmp &&\
	rm -rf /tmp/${OPENSSL_VER}.tar.gz /tmp/${OPENSSL_VER})

RUN (wget https://testssl.sh/testssl.sh -O /usr/local/bin/testssl.sh &&\
	chmod +x /usr/local/bin/testssl.sh)

ENTRYPOINT ["/usr/local/bin/testssl.sh"]
CMD ["-h"]
