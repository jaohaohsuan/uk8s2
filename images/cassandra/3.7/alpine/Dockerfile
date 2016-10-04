FROM anapsix/alpine-java:8_jdk

ARG user=cassandra
ARG group=cassandra
ARG uid=1002
ARG gid=1002

RUN addgroup -g ${gid} ${group} \
    && adduser -u ${uid} -G ${group} -s /bin/bash -D ${user}

RUN apk add --no-cache --virtual build-deps curl \
  && curl -Ls http://ftp.tc.edu.tw/pub/Apache/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz | tar xz \
  && rm -rf /apache-cassandra-3.7/doc \
            /apache-cassandra-3.7/javadoc \
            /apache-cassandra-3.7/tools \
            /apache-cassandra-3.7/pylib \
  && rm     /apache-cassandra-3.7/*.txt \
  && rm     /apache-cassandra-3.7/tools/bin/*.bat \
  && rm     /apache-cassandra-3.7/bin/*.bat \
  && mv /apache-cassandra-3.7 /opt/cassandra \
  && curl -Ls https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init \
  && chmod 755 /usr/local/bin/dumb-init \
  && apk del build-deps \
  && apk add --no-cache bash \
  && rm -rf /var/cache/apk/* 

RUN bash -c 'mkdir -pv /opt/cassandra/{data/{data,commitlog,saved_caches,hints},logs}' \
    && chown -R ${user} /opt/cassandra

# cqlsh dependencies
#RUN apk add --no-cache python py-pip &&  pip install cassandra-driver

USER cassandra
COPY run.sh token.txt /
#COPY limits.conf /etc/security/limits.conf

#ENV CQLSH_NO_BUNDLED true
ENV CASSANDRA_CONFIG /opt/cassandra/conf
ENV PATH $PATH:/opt/cassandra/bin

VOLUME ["/opt/cassandra/logs", "/opt/cassandra/data"]

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
