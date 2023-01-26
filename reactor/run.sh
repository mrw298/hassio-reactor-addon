#!/usr/bin/env bashio

HASS_CONFIG_PATH="/data/options.json"
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

REACTOR_HASS_TOKEN=$(jq --raw-output '.long_lived_token // empty' $HASS_CONFIG_PATH)
if [ -n "$REACTOR_HASS_TOKEN" ]; then
  echo "Reactor Token is set, updating config"
  yq eval -i "(.controllers[] | select(.id==\"hass\").config.access_token) |= \"$REACTOR_HASS_TOKEN\"" $CONFIG_DIR/reactor.yaml
fi

# Run the app
node app.js -c /config/reactor
