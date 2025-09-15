FROM osrf/ros:humble-desktop-full

# Refresh ROS apt repo & key (fixes expired key issue)
RUN apt-get update && apt-get install -y --reinstall ros2-apt-source

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    git \
    python3-pip \
    libpaho-mqtt-dev \
    libpaho-mqttpp-dev \
    libssl-dev \
    && apt-get clean

# (Optional) Use a faster Ubuntu mirror
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirror.kumi.systems/ubuntu|g' /etc/apt/sources.list

# Source ROS in bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# Setup workspace
RUN mkdir -p /home/hfluently_ws/src
WORKDIR /home/hfluently_ws/src

# Clone your package
RUN git clone https://github.com/ika-rwth-aachen/mqtt_client.git

# Copy Fast DDS profile
COPY fastrtps-profile.xml /home/
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/home/fastrtps-profile.xml

# Build workspace
WORKDIR /home/hfluently_ws
RUN . /opt/ros/humble/setup.sh && \
    rosdep update && \
    rosdep install -r --ignore-src --from-paths . -y && \
    colcon build --packages-up-to mqtt_client --cmake-args -DCMAKE_BUILD_TYPE=Release

# Copy custom config
COPY ros2_params_mqtt_hfluently.yaml /home/hfluently_ws/src/mqtt_client/mqtt_client/config

# Copy entrypoint script
COPY ./script.sh /
RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
