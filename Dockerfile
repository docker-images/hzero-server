FROM centos

RUN yum clean all && yum clean metadata && yum clean dbcache && yum makecache && yum update \
  && yum install -y wget \
  && yum install -y  gcc-c++ pcre pcre-devel zlib zlib-devel  openssl openssl-devel \
  && yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel \
  && yum install -y gcc perl-ExtUtils-MakeMaker  \
  && yum clean all && rm -rf /var/cache/yum/*

RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.22.0.tar.gz \
  && tar -zxf git-2.22.0.tar.gz && mv git-2.22.0 /usr/local/src/git-2.22.0  && rm -f git-2.22.0.tar.gz \
  && cd  /usr/local/src/git-2.22.0 && ./configure --prefix=/usr/local/git \
  $$ make && make install


ENV JAVA_VERSION="1.8.0_212" JAVA_HOME="/usr/local/src/jdk${JAVA_VERSION}" PATH="${PATH}:${JAVA_HOME}/bin"

RUN  mkdir -p /usr/local/src \
  && wget https://github.com/chenquan/oracle-jdk-download/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
  && tar -xzf jdk-8u212-linux-x64.tar.gz && mv jdk${JAVA_VERSION} /usr/local/src/ && rm -f jdk-8u212-linux-x64.tar.gz

RUN wget http://nginx.org/download/nginx-1.8.1.tar.gz \
  && tar -zxvf nginx-1.8.1.tar.gz && rm -f nginx-1.8.1.tar.gz  && cd nginx-1.8.1 \
  && ./configure --prefix=/usr/src/nginx --with-http_stub_status_module --with-http_ssl_module \
  && make && make install \
  && cd /usr/src/nginx/sbin \
  && ./nginx -v \
  && echo "/usr/src/nginx/sbin/nginx" >> /etc/rc.local \
  && cd /usr/src/nginx/sbin && ./nginx \
  && rm -rf /nginx-1.8.1

RUN wget https://nodejs.org/dist/v10.15.0/node-v10.15.0-linux-x64.tar.xz \
  && tar -xvf node-v10.15.0-linux-x64.tar.xz && rm -f node-v10.15.0-linux-x64.tar.xz \
  && mv node-v10.15.0-linux-x64 /usr/local/node-v10.15.0 \
  && ln -s /usr/local/node-v10.15.0/bin/node /usr/local/bin/node \
  && ln -s /usr/local/node-v10.15.0/bin/npm /usr/local/bin/npm \
  && ln -s /usr/local/node-v10.15.0/bin/npx /usr/local/bin/npx \
  && node -v && npm -v && npx -v

ENV MAVEN_HOME="/usr/local/maven3"\
  PATH="$MAVEN_HOME/bin:$PATH"
RUN wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
  && tar -zxvf apache-maven-3.3.9-bin.tar.gz \
  && mv apache-maven-3.3.9 /usr/local/maven3  && rm -f apache-maven-3.3.9-bin.tar.gz \
  && touch /etc/profile.d/mvn.sh \
  && echo "export MAVEN_HOME=/usr/local/maven3" >> /etc/profile.d/mvn.sh \
  && echo "export PATH=$MAVEN_HOME/bin:$PATH" >> /etc/profile.d/mvn.sh \
  && source /etc/profile \
  && rm -f /usr/local/maven3/conf/settings.xml
COPY ./settings.xml  /usr/local/maven3/conf/settings.xml
