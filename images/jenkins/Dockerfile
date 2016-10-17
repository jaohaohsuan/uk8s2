FROM jenkins:2.19.1-alpine
RUN /usr/local/bin/install-plugins.sh \
    kubernetes-ci \
    ansicolor:0.4.2
ENV JAVA_OPTS -Dorg.apache.commons.jelly.tags.fmt.timeZone=Asia/Taipei
