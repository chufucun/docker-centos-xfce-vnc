#!/bin/bash

# add cloudera source
sudo cp cloudera-cdh6.repo /etc/yum.repos.d/

sudo yum install impala-udf-devel -y

