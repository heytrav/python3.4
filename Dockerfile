FROM quay.io/heytrav/logstash-forwarder:v0.2.3
MAINTAINER Travis Holton <travis@ideegeo.com>

RUN  apt-get  update && \
  apt-get -qy install -y \
    libncurses5-dev \
    python3.4-dev \
    python3-pip \
    libpgm-5.1-0 \
    libzmq-dev \
    libzmq3 \
    supervisor \
    inotify-tools \
    curl && \
    apt-get clean
