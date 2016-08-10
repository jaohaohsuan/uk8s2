# uk8s2
use ansible to build kubernetes on ubuntu 16.04

###installation
**create your inventory file at `./inventory` directory**

*mandatory vars:*

- `flannel_ifac`
- `etcd_ifac`
- ` flannel_etcd_group_name`

*mandatory groups:*

- glusters
- etcd
- nodes

> notice: ubuntu 16.04 shoud set `ansible_python_interpreter=/usr/bin/python2.7`.

```
localhost ansible_connection=local flannel_ifac=enp0s8 ansible_python_interpreter=/usr/bin/python2.7
master117 ansible_host=192.168.80.117 flannel_ifac=enp2s0f0 etcd_ifac=enp2s0f0 ansible_python_interpreter=/usr/bin/python2.7

[xenial]
master117

[etcd]
master117

[nodes]
master117
localhost

[nodes:vars]
flannel_etcd_group_name=etcd

[glusters]
master117

[glusters:vars]
glusterfs_ifac=enp2s0f0
```
**create your won cows list like this**

```
-p 22 user@192.168.80.117
-p 22 user@192.168.80.119
```
> `-p` is ssh port. Later `setup-cows.yml` playbook will ask the **cows file path**.

**create ssh connection & install python 2.7 if possible**

```ansible-playbook -i inventory/home setup-cows.yml```

**download kubernetes from github release to local**

```
ansible-playbook -i inventory/home k8s-install.yml
```

**gen cert makes kubernete api-server using HTTPS**

```
ansible-playbook -i inventory/home k8s-tls.yml
```

**create a single kubernetes master**

support tags: `etcd`, `pv`, `upgrade:?` and `master`.

```
ansible-playbook -i inventory/home single-master.yml
```

**add nodes to serve**

create a file(named as your `machine`) in `host_vars` directory like this

```
# kubernetes node labels
node:
  labels: "env=production"
```

`become-node.yml` support tags: `init`, `use-docker-mirror`, and `upgrade:?`.

```
ansible-playbook -i inventory/home become-node.yml --skip-tags "use-docker-mirror"

# if already a node
ansible-playbook -i inventory/home become-node.yml --skip-tags "init"
```

###deploy infra

support tags: `cassandra`.

```
ansible-playbook -i inventory/home infra.yml

# skip cassandra petset deploy
ansible-playbook -i inventory/home infra.yml --skip-tags "cassandra"
```

###upgrade

for example, upgrade kubernetes to v1.3.4 and it requires the version and checksum.

```
# step 1
ansible-playbook -i inventory/home k8s-install.yml

# step 2
ansible-playbook -i inventory/home single-master.yml --tags "upgrade:v1.3.4"

# step 3
ansible-playbook -i inventory/home become-node.yml --skip-tags "init" --tags "upgrade:v1.3.4"
```

