#!/bin/bash
tar -xf /tmp/sbt-caches.tar.gz
/usr/local/bin/jenkins-slave "$@"
