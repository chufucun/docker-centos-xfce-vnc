#!/bin/bash

# add cloudera source
sudo mv cloudera-cdh6.repo /etc/yum.repos.d/

sudo yum install impala-udf-devel -y

sudo yum impala-udf-devel -y
