#!/bin/bash
# This script has exec by root user.

# Install tools
apt -y install build-essential pandoc libffi-dev

# pyenv
#git clone git://github.com/yyuu/pyenv.git /usr/local/pyenv
#echo 'export PYENV_ROOT="/usr/local/pyenv"' | tee -a /etc/bash.bashrc
#echo 'export PATH="/usr/local/pyenv/bin:$PATH"' | tee -a /etc/bash.bashrc
#echo 'eval "$(pyenv init -)"' | tee -a /etc/bash.bashrc
#source /etc/bash.bashrc
#pyenv install 3.7.1
#pyenv global 3.7.1

# Install requirements
pip install --upgrade google-cloud
pip install --upgrade google-api-python-client
pip install --upgrade pytz
pip install --upgrade wheel
pip install --upgrade numpy
pip install --upgrade pyspark

# Setup python3 for Dataproc
echo "export PYSPARK_PYTHON=python3" | tee -a /etc/profile.d/spark_config.sh /etc/bash.bashrc /usr/lib/spark/conf/spark-env.sh
echo "export PYTHONHASHSEED=0" | tee -a /etc/profile.d/spark_config.sh /etc/bash.bashrc /usr/lib/spark/conf/spark-env.sh
echo "spark.executorEnv.PYTHONHASHSEED=0" | tee -a /etc/spark/conf/spark-defaults.conf
