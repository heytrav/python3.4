FROM ubuntu:trusty
MAINTAINER Travis Holton <travis@ideegeo.com>

RUN sh -c "echo 'deb http://apt.datadoghq.com/ stable main' > /etc/apt/sources.list.d/datadog.list"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7A7DA52

RUN  apt-get  update && \
  apt-get -qy install -y \
    libncurses5-dev \
    python3.4-dev \
    python3-pip \
    libpgm-5.1-0 \
    libzmq-dev \
    libzmq3 \
    datadog-agent \
    supervisor \
    inotify-tools \
    curl && \
    apt-get clean

