FROM registry.access.redhat.com/rhel7/rhel

MAINTAINER Stuart Winchester <swinches@redhat.com>

ENV EMS_VERSION 8.4
ENV TIBCO_HOME /opt/tibco
ENV EMS_HOME /opt/tibco/ems/8.4

ARG EMS_DOWNLOAD=http://192.168.122.50:8081/nexus/content/repositories/thirdparty/com/tibco/tibems-installer/8.4.0/tibems-installer-8.4.0.zip
ARG EMS_INSTALLER_FILE=tibems-installer-8.4.0.zip

USER root

RUN yum install -y \
    wget \
    unzip \
    tar \
    bc \
    lib32stdc++6 \
    glibc.i686 \
    libc6-i386 \
    libstdc++.i686 \
    libstdc++-devel.i686

WORKDIR /root

RUN curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm > jdk-7u79-linux-x64.rpm && \
    yum -y localinstall jdk-7u79-linux-x64.rpm

RUN wget $EMS_DOWNLOAD -O \
  		$EMS_INSTALLER_FILE && \
  	unzip $EMS_INSTALLER_FILE && \
    rm -rf $EMS_INSTALLER_FILE

ADD cfgmgmt/ /etc/opt/cfgmgmt

#Intsall EMS
RUN chmod +x TIBCOUniversalInstaller-lnx-x86-64.bin && \
    ./TIBCOUniversalInstaller-lnx-x86-64.bin -silent

#Remove bulky installer files
RUN rm TIBCOUniversalInstaller* && \
    mkdir -p /var/opt/ems/log && \
    mkdir -p /var/opt/ems/certs && \
    mkdir -p /var/opt/ems/data/datastore 

RUN chmod 777 -R /var/opt/ems && \
    chmod 777 -R /etc/opt/cfgmgmt

#expose data and log volume
VOLUME /var/opt/ems/log
VOLUME /var/opt/ems/data/datastore
VOLUME /var/opt/ems/certs

EXPOSE 7222
EXPOSE 7243

# RUN EMS
#CMD ["sh", "-c", "/opt/tibco/ems/${EMS_VERSION}/bin/tibemsd", "-config", "/etc/opt/cfgmgmt/tibemsd-default.conf"]
CMD ["/opt/tibco/ems/8.4/bin/tibemsd", "-config", "/etc/opt/cfgmgmt/tibemsd.conf"]
