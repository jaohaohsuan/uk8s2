#!/bin/sh

# allow for memlock
# ulimit -l unlimited

chmod g+w /data


# set environment
export PATH=$PATH:/opt/elasticsearch/bin:/usr/local/bin
export CLUSTER_NAME=${CLUSTER_NAME:-elasticsearch-default}
export ZEN_HOSTS=${ZEN_HOSTS:-127.0.0.1}
export NODE_MASTER=${NODE_MASTER:-true}
export NODE_DATA=${NODE_DATA:-true}
export HTTP_ENABLE=${HTTP_ENABLE:-true}
export NETWORK_HOST=${NETWORK_HOST:-_site_}
export HTTP_CORS_ENABLE=${HTTP_CORS_ENABLE:-true}
export HTTP_CORS_ALLOW_ORIGIN=${HTTP_CORS_ALLOW_ORIGIN:-*}
export ES_HEAP_SIZE=${ES_HEAP_SIZE:-2048m}
export NUMBER_OF_SHARDS=${NUMBER_OF_SHARDS:-5}
export NUMBER_OF_REPLICAS=${NUMBER_OF_REPLICAS:-1}

#ulimit -l unlimited

sudo -E -u alpine "$@"