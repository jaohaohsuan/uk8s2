FROM anapsix/alpine-java:8_jdk

RUN apk add --no-cache --virtual build-deps curl \
  && curl -Ls http://ftp.tc.edu.tw/pub/Apache/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz | tar xz \
  && rm -rf /apache-cassandra-3.7/doc \
            /apache-cassandra-3.7/javadoc \
            /apache-cassandra-3.7/tools \
            /apache-cassandra-3.7/pylib \
  && rm     /apache-cassandra-3.7/*.txt \
  && rm     /apache-cassandra-3.7/bin/*.bat \
  && mv /apache-cassandra-3.7 /opt/cassandra \
  && curl -Ls https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init \
  && chmod g+x /usr/local/bin/dumb-init \
  && apk del build-deps \
  && apk add --no-cache bash sudo \
  && rm -rf /var/cache/apk/*

COPY run.sh /

RUN chmod g+x /run.sh && \
    bash -c 'mkdir -pv /opt/cassandra/{data/{data,commitlog,saved_caches,hints},logs}' && \
    adduser -h /home/cassandra -s /bin/sh -D -G root cassandra && \
    chown -R cassandra /opt/cassandra
#COPY limits.conf /etc/security/limits.conf

ENV CASSANDRA_CONFIG /opt/cassandra/conf

#VOLUME ["/opt/cassandra/logs", "/opt/cassandra/data"]

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
