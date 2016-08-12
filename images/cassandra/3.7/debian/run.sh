#!/bin/bash
set -ex

CASSANDRA_RPC_ADDRESS=0.0.0.0
CASSANDRA_LISTEN_ADDRESS="${POD_IP}"
CASSANDRA_BROADCAST_ADDRESS="${POD_IP}"
CASSANDRA_BROADCAST_RPC_ADDRESS=$CASSANDRA_BROADCAST_ADDRESS

sed -ri 's/(- seeds:).*/\1 "'"$CASSANDRA_SEEDS"'"/' "$CASSANDRA_CONFIG/cassandra.yaml"

if [[ $CASSANDRA_DC && $CASSANDRA_RACK ]]; then
  CASSANDRA_ENDPOINT_SNITCH="GossipingPropertyFileSnitch"
fi

for yaml in \
  broadcast_address \
  broadcast_rpc_address \
  cluster_name \
  endpoint_snitch \
  listen_address \
  num_tokens \
  rpc_address \
  start_rpc \
; do
  var="CASSANDRA_${yaml^^}"
  val="${!var}"
  if [ "$val" ]; then
    sed -ri 's/^(# )?('"$yaml"':).*/\2 '"$val"'/' "$CASSANDRA_CONFIG/cassandra.yaml"
  fi
done

for rackdc in dc rack; do
  var="CASSANDRA_${rackdc^^}"
  val="${!var}"
  if [ "$val" ]; then
    sed -ri 's/^('"$rackdc"'=).*/\1 '"$val"'/' "$CASSANDRA_CONFIG/cassandra-rackdc.properties"
  fi
done

set +ex

cassandra -f -R