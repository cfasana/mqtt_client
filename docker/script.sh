#!/bin/bash
set -e
export FASTRTPS_DEFAULT_PROFILES_FILE=/home/fastrtps-profile.xml
export MQTT_PORT=${MQTT_PORT:-1883}
export MQTT_HOST="${MQTT_HOST:-localhost}"
export CELL="${CELL:-client}"

export CELL_UPPER=$(echo "$CELL" | tr '[:lower:]' '[:upper:]')
export CELL_LOWER=$(echo "$CELL" | tr '[:upper:]' '[:lower:]')


envsubst < /home/hfluently_ws/src/mqtt_client/mqtt_client/config/ros2_params_mqtt_template.yaml \
  > /home/hfluently_ws/src/mqtt_client/mqtt_client/config/ros2_params_mqtt_hfluently.yaml


echo "---- RUNNING CONFIG ----"
cat /home/hfluently_ws/src/mqtt_client/mqtt_client/config/ros2_params_mqtt_hfluently.yaml
echo "-----------------------"

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
source "/home/hfluently_ws/install/setup.bash" --
ros2 launch mqtt_client standalone.launch.xml params_file:="/home/hfluently_ws/src/mqtt_client/mqtt_client/config/ros2_params_mqtt_hfluently.yaml"
exec "$@"


