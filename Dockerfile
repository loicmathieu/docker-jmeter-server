FROM openjdk:11-slim

LABEL maintainer="Loïc Mathieu <loicmathieu@free.fr>"

ARG JMETER_VERSION="5.0"
ARG JMETER_DOWNLOAD_URL=https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN=${JMETER_HOME}/bin

# Install curl
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Install JMeter
RUN mkdir /tmp/jmeter \
  && curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/jmeter/apache-jmeter-${JMETER_VERSION}.tgz  \
  && mkdir -p /opt  \
  && tar -xzf /tmp/jmeter/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
  && rm -rf /tmp/jmeter

# Add plugins
COPY plugins/ ${JMETER_HOME}/lib/ext

ENV RMI_PORT=1099
ENV MY_IP=127.0.0.1

EXPOSE ${RMI_PORT}

WORKDIR $JMETER_HOME

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
