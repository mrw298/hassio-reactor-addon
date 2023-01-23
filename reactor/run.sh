#!/bin/bash

CONFIG_DIR="/config/reactor"
CONFIG_SRC="/opt/reactor/dist-config"

# Setup the config
if [ ! -d "$CONFIG_DIR" ]; then
  echo "New setup, copy dist-config files to /config/reactor"
  cp -vaR $CONFIG_SRC $CONFIG_DIR
else
  echo "Using existing set-up"
fi

# Run the app
node app.js -c /config/reactor
