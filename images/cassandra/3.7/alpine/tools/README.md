# how to use
## build image
the image name: `127.0.0.1:5000/inu/cassandra-tools:3.7-alpine`
```
./build.sh
```
## create tools
```
kubectl create -f cassandra-tool.yml
```
## cqlsh
```
kubectl exec -it cassandra-tools -- cqlsh cassandra-data-0.cassandra.default.svc.cluster.local 9042
```
