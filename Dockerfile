FROM ubuntu:trusty
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


RUN sed -i 's/RSYSLOG_TraditionalFileFormat/RSYSLOG_ForwardFormat/' /etc/rsyslog.conf
