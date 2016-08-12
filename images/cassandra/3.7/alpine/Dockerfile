FROM anapsix/alpine-java:8_jdk

RUN apk add --no-cache --virtual .fetch-deps curl \
  && curl -Ls http://ftp.tc.edu.tw/pub/Apache/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz | tar xz \
  && rm -rf /apache-cassandra-3.7/doc \
            /apache-cassandra-3.7/javadoc \
            /apache-cassandra-3.7/tools \
            /apache-cassandra-3.7/pylib \
  && rm     /apache-cassandra-3.7/*.txt \
  && mv /apache-cassandra-3.7 /opt/cassandra \
  && curl -Ls https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init \
  && chmod +x /usr/local/bin/dumb-init \
  && apk del .fetch-deps \
  && apk add --no-cache bash \
  && rm -rf /var/cache/apk/*

ENV PATH=$PATH:/opt/cassandra/bin
ENV CASSANDRA_CONFIG /opt/cassandra/conf

COPY run.sh /

RUN chmod +x /run.sh

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]