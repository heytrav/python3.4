FROM ubuntu:trusty
MAINTAINER Travis Holton <travis@ideegeo.com>

RUN  apt-get  update && \
  apt-get -qy install wget --no-install-recommends && \
  apt-get -qy install -y \
    libncurses5-dev \
    python3.4-dev \
    python3-pip \
    libpgm-5.1-0 \
    libzmq-dev \
    libzmq3 \
    git \
    supervisor \
    rsyslog \
    collectd \
    golang 


# set up logstash forwarding
WORKDIR /tmp
RUN  \
    git clone git://github.com/elasticsearch/logstash-forwarder.git && \
   cd logstash-forwarder && \
   go build && \
   mkdir -p /opt/logstash-forwarder/bin  && \
   mv logstash-forwarder /opt/logstash-forwarder/bin/ && \
   mv logstash-forwarder.sh /opt/logstash-forwarder/bin/ && \
   mv logstash-forwarder.init /etc/init.d/logstash-forwarder && \
   apt-get -y remove git golang && \
   apt-get -y autoremove && \
   apt-get autoclean


RUN sed -i 's/$ActionFileDefaultTemplate/#$ActionFileDefaultTemplate/' /etc/rsyslog.conf
RUN sed -i 's/\#LoadPlugin network/LoadPlugin network/' /etc/collectd/collectd.conf
RUN echo "<Plugin network>\n<Server \"LOGSTASH_COLLECTD_SERVICE_HOST\" \"LOGSTASH_COLLECTD_SERVICE_PORT\">\n</Server>\n</Plugin>" >> /etc/collectd/collectd.conf
ADD supervisor/ /etc/supervisor/conf.d/
RUN chmod +x logstash-forwarder
ADD logstash-forwarder /etc/
