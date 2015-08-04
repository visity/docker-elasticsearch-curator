FROM	python:2.7

RUN pip install elasticsearch-curator==3.2.3

ENV INTERVAL_IN_HOURS=24
ENV OLDER_THAN_IN_DAYS="20"

CMD while true; do curator --host elasticsearch delete indices --older-than $OLDER_THAN_IN_DAYS --time-unit=days --timestring '%Y.%m.%d'; sleep $(( 60*60*INTERVAL_IN_HOURS )); done
