#!/bin/bash

JAVA_HOME="/usr/lib/jvm/java-1.8.0-amazon-corretto"

$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR resourcemanager
