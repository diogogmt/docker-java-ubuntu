FROM diogogmt/ubuntu:14.04.03

ENV JAVA_HOME="/usr/local/java"
ENV M2_HOME="/usr/local/mvn"

ENV JAVA_VERSION="8u51"
ENV JAVA_BUILD="b16"
ENV JAVA_PLATFORM="linux-x64"
ENV MVN_VERSION="3.3.3"

WORKDIR /tmp

## Install java
RUN  wget --no-check-certificate --no-cookies - --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$JAVA_BUILD/jdk-$JAVA_VERSION-$JAVA_PLATFORM.tar.gz || echo "Java download result $?"
RUN tar -xvzf jdk-$JAVA_VERSION-$JAVA_PLATFORM.tar.gz && \
    mv -f jdk1.8.* $JAVA_HOME

ENV PATH=$PATH:$JAVA_HOME/bin

## Install maven
RUN wget http://apache.parentingamerica.com/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz || echo "Maven download result $?"

RUN tar -xvf apache-maven-$MVN_VERSION-bin.tar.gz && \
    pwd && ls -lart && ls apache-maven* && \
    mv -f apache-maven-$MVN_VERSION $M2_HOME 

ENV PATH=$PATH:$M2_HOME/bin

COPY settings.xml $M2_HOME/conf/settings.xml
