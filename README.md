docker-elasticsearch2
=====================

Container for running [Elasticsearch 2.x](https://www.elastic.co/products/elasticsearch).

*Usage:*

* Build: `docker build -t elasticsearch .`
* Run: `docker run -d -v /data/elastic:/var/lib/elasticsearch -p 9300:9300 -p 9200:9200 elasticsearch`

*Extras:*

* Override default config file: `-v /data/myconfig.yml:/etc/elasticsearch/elasticsearch.yml`
