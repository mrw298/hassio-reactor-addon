#!/bin/bash

CONFIG_DIR="/config/reactor"
CONFIG_SRC="/var/reactor/config"

# Map the config
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Migrating configration to Home assistant"
  mv $CONFIG_SRC $CONFIG_DIR
fi

# Remove the directory inside the container and mount the Home assistant version instead
rm -rf $CONFIG_SRC
ln -s /config/reactor /var/reactor/config

# Run the app
node app.js