FROM ubuntu:trusty

RUN apt-get update ;\
    apt-get install -y software-properties-common ;\
    add-apt-repository -y ppa:webupd8team/java ;\
    apt-get update ;\
    echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections;\
    apt-get install -y oracle-java9-installer ;\
    rm -rf /var/lib/apt/lists/*

RUN apt-get update ;\
    apt-get install -y curl supervisor ;\
    curl -o /tmp/elasticsearch.deb "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.1.deb" ;\
    dpkg -i /tmp/elasticsearch.deb ;\
    rm /tmp/elasticsearch.deb ;\
    rm -rf /var/lib/apt/lists/*

ADD elasticsearch.conf /etc/supervisor/conf.d/elasticsearch.conf
ADD start /start

VOLUME /var/lib/elasticsearch/
ENTRYPOINT ["/start"]
EXPOSE 9200 9300
USER elasticsearch
