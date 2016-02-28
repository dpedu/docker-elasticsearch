FROM ubuntu:trusty

RUN apt-get update ;\
    apt-get install -y curl openjdk-7-jre-headless supervisor ;\
    curl -o /tmp/elasticsearch.deb "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.2.0/elasticsearch-2.2.0.deb" ;\
    dpkg -i /tmp/elasticsearch.deb ;\
    rm /tmp/elasticsearch.deb ;\
    rm -rf /var/lib/apt/lists/*

ADD elasticsearch.conf /etc/supervisor/conf.d/elasticsearch.conf
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

VOLUME /var/lib/elasticsearch/
ENTRYPOINT ["supervisord"]
EXPOSE 9200 9300
