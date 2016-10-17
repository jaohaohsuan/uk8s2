#Jenkins
在kubernetes中运行jenkins, 必须将jenkins master视为一个service，以便jenkins client可寻址，切勿用pod IP或host IP.
配置如下:
```
apiVersion: v1
kind: Service
metadata:
  name: jenkins
spec:
  type: NodePort
  selector:
    app: jenkins-master
  ports:
    - name: http
      port: 8080
    - name: jnlp
      port: 50000
```
NodePort Service会分配一组kubernetes内部的虚拟服务IP, 并随机分配30000~32767端口供外部访问(NodeIP:NodePort)

##Build image
```
docker build -t 127.0.0.1:5000/inu/jenkins:2.19.1-alpine
```
##Deploy
```
kubectl apply -f jenkins.yml
```
##Upgrade
查看最新的的官方jenkins镜像[here](https://hub.docker.com/_/jenkins/), 修改`Dockerfile`的基础镜像
```
#jenkins官方镜像版本
FROM jenkins:2.19.1-alpine
#添加你需要的plugins, 不指定版本号，每次build image会拿最新版本
RUN /usr/local/bin/install-plugins.sh \
    kubernetes-ci \
    ansicolor:0.4.2
```
