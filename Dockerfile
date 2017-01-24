FROM mcpayment/ubuntu1604

# https://launchpad.net/~webupd8team/+archive/ubuntu/java
# Add Oracle Java 8 PPA
#
# software-properties-common provides apt-add-repository

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y software-properties-common wget && \ 
    wget --no-verbose -O /tmp/apache-maven-3.2.2.tar.gz \
        http://archive.apache.org/dist/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz && \
    echo "87e5cc81bc4ab9b83986b3e77e6b3095 /tmp/apache-maven-3.2.2.tar.gz" | md5sum -c && \
    tar xzf /tmp/apache-maven-3.2.2.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-3.2.2 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin && \
    rm -f /tmp/apache-maven-3.2.2.tar.gz && \
    
    apt-add-repository ppa:webupd8team/java && \
    apt-get update -y && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y oracle-java8-unlimited-jce-policy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV MAVEN_HOME /opt/maven
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
