FROM alpine:3.7

RUN apk update && apk upgrade
RUN apk add chrony

COPY chrony.conf /etc/chrony/
COPY config_and_run.sh /usr/sbin

CMD /usr/sbin/config_and_run.sh
