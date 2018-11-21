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
echo "export PYSPARK_PYTHON=python3" | tee -a /etc/profile.d/spark_config.sh /etc/bash.bashrc /usr/lib/spark/conf/spark-env.sh
echo "export PYTHONHASHSEED=0" | tee -a /etc/profile.d/spark_config.sh /etc/bash.bashrc /usr/lib/spark/conf/spark-env.sh
echo "spark.executorEnv.PYTHONHASHSEED=0" | tee -a /etc/spark/conf/spark-defaults.conf
