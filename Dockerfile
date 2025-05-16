FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV PORT=8080

# Update system and install required packages
RUN apt-get update && apt-get install -y \
    firefox \
    xfce4 xfce4-goodies \
    x11vnc \
    xvfb \
    websockify \
    wget \
    python3 \
    net-tools \
    novnc \
    && apt-get clean

# Download noVNC and websockify if not included
RUN mkdir -p /opt/novnc/utils/websockify \
    && wget https://github.com/novnc/noVNC/archive/refs/heads/master.zip -O /tmp/novnc.zip \
    && unzip /tmp/novnc.zip -d /opt \
    && mv /opt/noVNC-master /opt/novnc \
    && wget https://github.com/novnc/websockify/archive/refs/heads/master.zip -O /tmp/ws.zip \
    && unzip /tmp/ws.zip -d /opt/novnc/utils \
    && mv /opt/novnc/utils/websockify-master /opt/novnc/utils/websockify

# Set up VNC password and permissions
RUN mkdir -p ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd

# Expose VNC over web (via noVNC)
EXPOSE 8080

# Start script
CMD bash -c "\
    Xvfb :1 -screen 0 1024x768x16 & \
    startxfce4 & \
    x11vnc -display :1 -forever -usepw -shared -rfbport 5900 & \
    /opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen ${PORT} \
"
