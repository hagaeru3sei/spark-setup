#!/bin/bash
# This script has exec by root user.

# Install tools
apt -y install build-essential pandoc

# Install requirements
pip3 install --upgrade google-cloud
pip3 install --upgrade google-api-python-client
pip3 install --upgrade pytz
pip3 install --upgrade wheel
pip3 install --upgrade numpy

# Setup python3 for Dataproc
env1="export PYSPARK_PYTHON=python3"
env2="export PYTHONHASHSEED=0"
env3="spark.executorEnv.PYTHONHASHSEED=0"

conf1="/etc/profile.d/spark_config.sh"
conf2="/etc/bash.bashrc"
conf3="/usr/lib/spark/conf/spark-env.sh"
conf4="/etc/spark/conf/spark-defaults.conf"

if [ $(grep -c $env1 $conf1) -lt 1 ]; then
  echo $env1 | tee -a $conf1
fi
if [ $(grep -c $env1 $conf2) -lt 1 ]; then
  echo $env1 | tee -a $conf2
fi
if [ $(grep -c $env1 $conf3) -lt 1 ]; then
  echo $env1 | tee -a $conf3
fi

if [ $(grep -c $env2 $conf1) -lt 1 ]; then
  echo $env2 | tee -a $conf1
fi
if [ $(grep -c $env2 $conf2) -lt 1 ]; then
  echo $env2 | tee -a $conf2
fi
if [ $(grep -c $env2 $conf3) -lt 1 ]; then
  echo $env2 | tee -a $conf3
fi

if [ $(grep -c $env3 $conf4) -lt 1 ]; then
  echo $env3 | tee -a $conf4
fi

