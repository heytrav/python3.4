FROM ubuntu:trusty
MAINTAINER Travis Holton <travis@ideegeo.com>

# set up logstash forwarding

RUN apt-get -qy install  ca-certificates wget --no-install-recommends && \
  wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
  echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | \
       tee /etc/apt/sources.list.d/logstashforwarder.list && \
  apt-get -qq update && \
  apt-get -qy install  logstash-forwarder

WORKDIR /etc/init.d
RUN \
    wget https://raw.github.com/elasticsearch/logstash-forwarder/master/logstash-forwarder.init \
    -O logstash-forwarder

RUN  apt-get  update && \
  apt-get -qy install -y libncurses5-dev \
    python3.4-dev python3-pip libpgm-5.1-0 libzmq-dev libzmq3 git supervisor rsyslog collectd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i 's/$ActionFileDefaultTemplate/#$ActionFileDefaultTemplate/' /etc/rsyslog.conf
RUN sed -i 's/\#LoadPlugin network/LoadPlugin network/' /etc/collectd/collectd.conf
RUN echo "<Plugin network>\n<Server \"172.17.8.102\" \"25826\">\n</Server>\n</Plugin>" >> /etc/collectd/collectd.conf
ADD supervisor/ /etc/supervisor/conf.d/
RUN chmod +x logstash-forwarder
ADD logstash-forwarder /etc/
