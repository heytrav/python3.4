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
    collectd \
    inotify-tools \
    curl && \
    apt-get clean



RUN sed -i 's/\#LoadPlugin network/LoadPlugin network/' /etc/collectd/collectd.conf
RUN echo "<Plugin network>\n<Server \"LOGSTASH_COLLECTD_SERVICE_HOST\" \"LOGSTASH_COLLECTD_SERVICE_PORT\">\n</Server>\n</Plugin>" >> /etc/collectd/collectd.conf
ADD supervisor/ /etc/supervisor/conf.d/
