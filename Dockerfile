FROM ubuntu:12.04
RUN mkdir /usr/lib/java
COPY jdk-7u79-linux-x64.tar.gz /usr/lib/java/
WORKDIR /usr/lib/java/
RUN tar -zxf jdk-7u79-linux-x64.tar.gz
#安装java
ENV JAVA_HOME=/usr/lib/java/jdk1.7.0_79
RUN echo "update-alternatives --display java"
RUN echo "export JAVA_HOME=$JAVA_HOME">> /etc/profile
RUN echo "export JRE_HOME=$JAVA_HOME/jre">> /etc/profile
RUN echo "export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib">> /etc/profile
RUN echo "export PATH=$JAVA_HOME/bin:$PATH">> /etc/profile
#替换源
RUN sed -i "s/archive/cn\.archive/g" /etc/apt/sources.list
#安装ssh
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed s/without-password/yes/g /etc/ssh/sshd_config >> /etc/ssh/sshd_config1
RUN rm -f /etc/ssh/sshd_config
RUN mv /etc/ssh/sshd_config1 /etc/ssh/sshd_config
RUN echo "root:root"|chpasswd
RUN touch /root/run.sh
