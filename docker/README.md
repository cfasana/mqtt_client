![mqtt2ros](./assets/mqtt2ros.png)  

Setup the MQTT2ROS bridge enabling the communication between H-Fluently and R-Fluently.

## Instructions
1) Clone this repository
2) Build the docker image (ensure the command is given from the docker folder, where `Dockerfile` is located):
```
docker build -t mqtt2ros .
```
3) Run the container by specifying the correct `ROS_DOMAIN_ID` and `MQTT_HOST` IPv4.
    ```
     docker run --name mqtt2ros --network host --rm -e ROS_DOMAIN_ID=<YOUR_ROS_DOMAIN_ID> -e MQTT_HOST=<YOUR_MQTT_BROKER_IP> mqtt2ros
    ```
    Verify that the MQTT broker is running and that the bridge is able to connect to the H-Fluently.

If you need further information or a practical example on how to allow an Android device to communicate with ROS-based device using the MQTT protocol, refer to [this](https://github.com/cfasana/mqtt2ros_android_example) repository.