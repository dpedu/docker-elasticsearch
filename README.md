docker-elasticsearch
====================

The latest [Elasticsearch](https://www.elastic.co/products/elasticsearch) for docker, currently 6.3.2.

*Usage:*

* Build: `docker build -t elasticsearch .`
* Run: `docker run -d -v /data/elastic:/var/lib/elasticsearch -p 9300:9300 -p 9200:9200 elasticsearch`

Note: you'll need to increase vm.max_map_count; Elasticsearch will demand it. Either add
`--sysctl vm.max_map_count=262144` to the `docker run` command or use `sysctl -w vm.max_map_count=262144`.

*Notes:*

* Override default config file: `-v /data/myconfig.yml:/etc/elasticsearch/elasticsearch.yml`
* Data is stored in `/var/lib/elasticsearch`
* Set memory limit like so: `-e "ES_JAVA_OPTS=-Xms8G -Xmx8G"
