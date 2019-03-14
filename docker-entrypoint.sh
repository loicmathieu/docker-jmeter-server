#!/bin/bash
exec jmeter-server \
    -D "java.rmi.server.hostname=${MY_IP}" \
    -D "client.rmi.localport=${RMI_PORT}" \
    -D "server.rmi.localport=${RMI_PORT}"
