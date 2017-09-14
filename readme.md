# docker-elasticsearch-curator

This only job executed by the docker built from this repository is to clean the elastic search logstash history leaving only a configurable amount of days worth of logging in the system. The job runs in the specified interval.

It can be run as follows:

	docker run -d -e INTERVAL_IN_HOURS=24 -e OLDER_THAN_IN_DAYS="10" -e ELASTICSEARCH_HOST="localhost" visity/elasticsearch-curator
	
* **INTERVAL\_IN\_HOURS**: The amount of time between two curator runs
* **OLDER\_THAN\_IN\_DAYS**: Indicates all logs with a date exceeding this age can be deleted.
* **ELASTICSEARCH\_HOST**: Points to the elasticsearch master url
* **ELASTICSEARCH\_MASTERS**: Optionally, other than ELASTICSEARCH\_HOST, a list of hosts can be provided here and the master will be chosen amongst them
* **ELASTICSEARCH\_PORT**: Port to access elasticsearch. It defaults to 9200

