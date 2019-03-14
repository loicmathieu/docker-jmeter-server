FROM openjdk:11

MAINTAINER Loïc Mathieu <loicmathieu@free.fr>

ARG JMETER_VERSION="5.1"
ARG JMETER_PLUGIN_VERSION="1.4.0"
ARG	JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ARG JMETER_PLUGIN_DOWNLOAD_URL https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-${JMETER_PLUGIN_VERSION}.zip

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin

# Install JMeter
RUN curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/jmeter/apache-jmeter-${JMETER_VERSION}.tgz  \
  && curl -L --silent ${JMETER_PLUGIN_DOWNLOAD_URL} >  /tmp/jmeter/JMeterPlugins-Standard-${JMETER_PLUGIN_VERSION}.zip
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/jmeter/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
  && unzip /tmp/jmeter/JMeterPlugins-Standard-${JMETER_PLUGIN_VERSION}.zip /opt/apache-jmeter-${JMETER_VERSION}/lib/ext
	&& rm -rf /tmp/jmeter

ENV RMI_PORT=1099
ENV MY_IP=127.0.0.1
ENV JVM_ARGS

EXPOSE ${RMI_PORT}

WORKDIR $JMETER_HOME

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
