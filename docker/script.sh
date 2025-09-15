#!/bin/bash
set -e
export FASTRTPS_DEFAULT_PROFILES_FILE=/home/fastrtps-profile.xml

# Generate dynamic config from environment variables
cat > /home/hfluently_ws/src/mqtt_client/mqtt_client/config/ros2_params_mqtt_hfluently.yaml <<EOF
mqtt_client:
  ros__parameters:
    broker:
      host: "${MQTT_HOST:-localhost}"
      port: 1883
    client:
      id: rfluently
      keep_alive_interval: 0.0
    bridge:
      ros2mqtt: 
        ros_topics:                 
          - /fluently/tts
          - /realwear/simple_intent
          - /hfluently/hfluently_request
          - /realwear/template_request
          - /fluently/forward_plan
          - /realwear/continue_disassembly
        /fluently/tts:              
          mqtt_topic: fluently/tts
          primitive: true
        /realwear/simple_intent:
          mqtt_topic: fluently/simple_intent
          primitive: true
        /hfluently/hfluently_request:
          mqtt_topic: fluently/command
          primitive: true
        /realwear/template_request:
          mqtt_topic: fluently/template_request
          primitive: true
        /fluently/forward_plan:              
          mqtt_topic: fluently/forward_plan
          primitive: true
        /realwear/continue_disassembly:              
          mqtt_topic: fluently/continue_disassembly
          primitive: true
      mqtt2ros:                     
        mqtt_topics:
          - MEM_transcription
          - fluently/user_input
          - fluently/stress_level
          - fluently/disassembly_plan
          - fluently/nlu_output
        MEM_transcription:          
          ros_topic: /hfluently/mem_transcription
          primitive: true
        fluently/user_input:       
          ros_topic: /hfluently/hfluently_response
          primitive: true
        fluently/stress_level:       
          ros_topic: /hfluently/human_state
          primitive: true
        fluently/disassembly_plan:       
          ros_topic: /realwear/disassembly_plan
          primitive: true
        fluently/nlu_output:       
          ros_topic: /nlu_output
          primitive: true
EOF


# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
source "/home/hfluently_ws/install/setup.bash" --
ros2 launch mqtt_client standalone.launch.xml params_file:="/home/hfluently_ws/src/mqtt_client/mqtt_client/config/ros2_params_mqtt_hfluently.yaml"
exec "$@"


