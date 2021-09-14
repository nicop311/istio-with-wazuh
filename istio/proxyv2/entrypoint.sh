#!/bin/bash

# The pilot-agent will bootstrap Envoy.
/usr/local/bin/pilot-agent wait

# Start the wazuh-agent
/var/ossec/bin/ossec-control start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start agent: $status"
  exit $status
fi
