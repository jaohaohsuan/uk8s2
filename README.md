# uk8s2

**create your inventory file at `./inventory` directory**

*mandatory vars:*

- `flannel_ifac`
- `etcd_ifac`
- ` flannel_etcd_group_name`

notice: ubuntu xenial shoud set `ansible_python_interpreter=/usr/bin/python2.7`

```
localhost ansible_connection=local flannel_ifac=enp0s8 ansible_python_interpreter=/usr/bin/python2.7
master117 ansible_host=192.168.80.117 flannel_ifac=enp2s0f0 etcd_ifac=enp2s0f0 ansible_python_interpreter=/usr/bin/python2.7

[xenial]
master117
localhost

[etcd]
master117

[nodes]
master117
localhost

[nodes:vars]
flannel_etcd_group_name=etcd

```
**create your won cows list like this**

```
-p 22 user@192.168.80.117
-p 22 user@192.168.80.119
```

*`-p` is ssh port*

later `setup-cows.yml` playbook will ask the **cows file path**

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

```
ansible-playbook -i inventory/home single-master.yml
```

**add nodes to serve**

```
ansible-playbook -i inventory/home become-node.yml
```
