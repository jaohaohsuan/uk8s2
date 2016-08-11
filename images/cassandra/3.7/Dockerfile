FROM debian:jessie-backports

#RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 514A2AD631A57A16DD0047EC749D6EEC0353B12C

RUN echo 'deb http://www.apache.org/dist/cassandra/debian 37x main' >> /etc/apt/sources.list.d/cassandra.list

RUN gpg --keyserver pgp.mit.edu --recv-keys 749D6EEC0353B12C \
  && gpg --export --armor 749D6EEC0353B12C | apt-key add -

ENV CASSANDRA_VERSION 3.7

RUN apt-get update \
	&& apt-get install --force-yes -y cassandra="$CASSANDRA_VERSION" \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install vim -y \
 && rm -rf /var/lib/apt/lists/*

COPY run.sh /

RUN chmod +x /run.sh

ENV CASSANDRA_CONFIG /etc/cassandra

ENTRYPOINT ["/run.sh"]