#!/bin/bash
exec ${JMETER_BIN}/jmeter-server \
    -D "java.rmi.server.hostname=${MY_IP}" \
    -D "client.rmi.localport=${RMI_PORT}" \
    -D "server.rmi.localport=${RMI_PORT}" \
    -J "server.rmi.ssl.disable=true"
