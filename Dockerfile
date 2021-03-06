FROM lnls/epics-base:base-3.15-debian-9.5

RUN apt-get update && \
    apt-get install -y wget build-essential checkinstall libreadline-gplv2-dev \ 
    libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev \
    libbz2-dev swig && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz && \
	tar xzf Python-3.6.1.tgz && rm -f /Python-3.6.1.tgz && \
    cd /Python-3.6.1 && \
    ./configure --enable-shared --with-ensurepip=install && \
	make -j32 && \
	make altinstall && \
	ldconfig && \
	ln -f -s /usr/local/bin/python3.6 /usr/bin/python-sirius && \
    cd / && rm -rf /Python-3.6.1


ENV EPICS_BASE=/opt/epics/base
ENV EPICS_HOST_ARCH=linux-x86_64

ENTRYPOINT bash