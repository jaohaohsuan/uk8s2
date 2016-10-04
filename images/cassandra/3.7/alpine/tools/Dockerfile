FROM anapsix/alpine-java:8_jdk

ARG user=cassandra
ARG group=cassandra
ARG uid=1002
ARG gid=1002

RUN addgroup -g ${gid} ${group} \
    && adduser -u ${uid} -G ${group} -s /bin/bash -D ${user}

RUN apk add --no-cache --virtual build-deps curl \
  && curl -Ls http://ftp.tc.edu.tw/pub/Apache/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz | tar xz \
  && mv /apache-cassandra-3.7 /opt/cassandra \
  && curl -Ls https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init \
  && chmod 755 /usr/local/bin/dumb-init \
  && apk del build-deps \
  && apk add --no-cache bash python py-pip \
  && pip install cassandra-driver \
  && rm -rf /var/cache/apk/* \
  && chown -R ${user} /opt/cassandra

ENV CQLSH_NO_BUNDLED true
ENV PATH $PATH:/opt/cassandra/bin

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
USER cassandra
