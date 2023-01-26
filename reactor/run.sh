#!/bin/bash

CONFIG_DIR="/config/reactor"
CONFIG_SRC="/opt/reactor/dist-config"

# Setup the config
if [ ! -d "$CONFIG_DIR" ]; then
  echo "New setup, copy dist-config files to /config/reactor"
  cp -vaR $CONFIG_SRC $CONFIG_DIR
  
  echo "Configure hass"
  yq eval -i '(.controllers[] | select(.id=="hass").config.source) |= "ws://homeassistant.local:8123"' $CONFIG_DIR/reactor.yaml
  yq eval -i '(.controllers[] | select(.id=="hass").enabled) |= true' $CONFIG_DIR/reactor.yaml
else
  echo "Using existing set-up"
fi


#yq eval -i "(.controllers[] | select(.id==\"hass\").config.access_token) |= \"$HASSIO_TOKEN\"" $CONFIG_DIR/reactor.yaml

# Run the app
node app.js -c /config/reactor
