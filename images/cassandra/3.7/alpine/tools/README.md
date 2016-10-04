## create tools
```
kubectl create -f cassandra-tool.yml
```
## cqlsh
```
kubectl exec -it cassandra-tools -- cqlsh cassandra-data-0.cassandra.default.svc.cluster.local 9042
```
