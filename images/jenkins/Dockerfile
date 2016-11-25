FROM jenkins:2.19.2-alpine
RUN /usr/local/bin/install-plugins.sh \
    kubernetes-ci \
    ansicolor:0.4.2
#    credentials \
#    display-url-api \
#    workflow-step-api \
#    script-security \
ENV JAVA_OPTS -Dorg.apache.commons.jelly.tags.fmt.timeZone=Asia/Taipei
COPY config.xml /usr/share/jenkins/ref/config.xml.override
