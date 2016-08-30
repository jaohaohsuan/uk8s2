FROM anapsix/alpine-java

ENV VERSION 2.3.5
RUN apk add --no-cache --virtual .fetch-deps curl && \
    curl -Ls https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init && \
    chmod g+x /usr/local/bin/dumb-init && \
    mkdir -p /opt && \
    curl -Ls https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${VERSION}/elasticsearch-${VERSION}.tar.gz | tar xz && \
    mv /elasticsearch-$VERSION /opt/elasticsearch && \
    rm -rf $(find /opt/elasticsearch | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") && \
    apk del .fetch-deps && \
    rm -rf /var/cache/apk && \
    adduser -h /home/alpine -s /bin/sh -D -G root alpine && \
    chown -R alpine /opt/elasticsearch
#    adduser alpine -G root && \
#    apk add --no-cache sudo && \
#    echo "alpine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#    chown -R alpine:alpine /opt/elasticsearch

# ./opt/elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/${VERSION} -b && \

COPY run.sh /usr/local/bin/run.sh
COPY config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
RUN chmod g+x /usr/local/bin/run.sh
RUN apk add --no-cache sudo bash

VOLUME /data
#USER alpine


ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/local/bin/run.sh", "/opt/elasticsearch/bin/elasticsearch"]