FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y wget curl

ADD get_oracle_jdk_linux_x64.sh /

RUN /get_oracle_jdk_linux_x64.sh 8 tar.gz && \
    mkdir  -p /srv/java/8 && \
    tar xvf java.tar.gz -C /srv/java/8/ --strip-components=1

FROM ubuntu:bionic
COPY --from=0 /srv /srv

ENV PATH=/srv/java/8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get install -yqq wget && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb
RUN wget -qO /tmp/elasticsearch.deb "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.2.deb" && \
    dpkg -i /tmp/elasticsearch.deb && \
    rm /tmp/elasticsearch.deb && \
    sed -i -E 's|^[^#]|#\0|' /etc/elasticsearch/elasticsearch.yml && \
    sed -i -E 's/(\-Xm.[0-9]g)/#\1/' /etc/elasticsearch/jvm.options

ADD start /start

VOLUME /var/lib/elasticsearch/
ENTRYPOINT ["/start"]
EXPOSE 9200 9300
USER elasticsearch
