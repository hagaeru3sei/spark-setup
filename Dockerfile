FROM adoptopenjdk/openjdk8:latest

ENV HADOOP_VERSION 2.7.7
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION
ENV PATH $PATH:$HADOOP_HOME/bin
ENV SPARK_VERSION 2.4.0
ENV SPARK_HOME=/home/spark
ENV PATH $PATH:$SPARK_HOME/bin

RUN useradd -ms /bin/bash hadoop
RUN useradd -ms /bin/bash spark
RUN apt -y update && apt -y upgrade
RUN curl "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" | tar zx -C /opt/ \
 && chown -R hadoop:hadoop $HADOOP_HOME
RUN curl "http://ftp.riken.jp/net/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz" | tar zx --strip-components 1 -C $SPARK_HOME \
 && chown -R spark:spark $SPARK_HOME

USER root
WORKDIR $SPARK_HOME
#CMD ["su", "-c", "bin/spark-class org.apache.spark.deploy.master.Master", "spark"]
