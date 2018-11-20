#!/usr/bin/env bash

# install
sudo apt update
sudo apt install -y build-essential checkinstall
sudo apt install -y libreadline-gplv2-dev libsqlite3-dev libgdbm-dev libbz2-dev
sudo apt install -y zlib1g-dev libncursesw5-dev libgdbm-dev libc6-dev tk-dev libffi-dev libssl-dev
sudo apt install -y apt-transport-https dirmngr
sudo apt install -y openjdk-8-jdk

# swapoff for k8s
sudo cp setup/rc.local /etc/rc.local

# pyenv
pyenv_dir=~/.pyenv

if [ ! -d $pyenv_dir ]; then
  git clone https://github.com/yyuu/pyenv.git $pyenv_dir

  echo '# python' >> ~/.profile
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
  echo 'eval "$(pyenv init -)"' >> ~/.profile
  echo '' >> ~/.profile
  echo '# java' >> ~/.profile
  echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.profile
fi

source ~/.profile

pyenv install 3.7.0
pyenv global 3.7.0

mkdir -p ~/sandbox/example
cd ~/sandbox/example

# venv
python -m venv venv
source venv/bin/activate

# pip
pip install requirements.txt

# hadoop
if [ ! -f hadoop-2.7.7.tar.gz ]; then
  cd ~
  wget http://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
  tar zxvf hadoop-2.7.7.tar.gz
  echo '' >> ~/.profile
  echo '# hadoop' >> ~/.profile
  echo 'export HADOOP_HOME="~/hadoop-2.7.7"' >> ~/.profile
  echo 'export PATH="$PATH:$HADOOP_HOME/bin"' >> ~/.profile
fi

# spark
if [ ! -f ~/spark-2.4.0-bin-hadoop2.7.tgz ]; then
  cd ~
  wget "http://ftp.tsukuba.wide.ad.jp/software/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz"
  tar zxvf spark-2.4.0-bin-hadoop2.7.tgz
  echo '' >> ~/.profile
  echo '# spark' >> ~/.profile
  echo 'export SPARK_HOME="~/spark-2.4.0-bin-hadoop2.7"' >> ~/.profile
  echo 'export PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"' >> ~/.profile
  source ~/.profile
fi

# sbt
echo 'deb https://dl.bintray.com/sbt/debian /' | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt update
sudo apt install sbt

# reload env
source ~/.profile

exit 0
