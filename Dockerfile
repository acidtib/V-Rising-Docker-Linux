FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"
ENV TZ="America/New_York"

RUN dpkg --add-architecture i386 \
    && apt update \
    && apt install -y wine64 wine32 wget unzip xvfb \
    && mkdir -p /root/.wine/drive_c/steamcmd \
    && mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/'Stunlock Studios'/VRisingServer/Settings \
    && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -P /root/.wine/drive_c/steamcmd/ \
    && cd /root/.wine/drive_c/steamcmd/ \
    && unzip steamcmd.zip \
    && mkdir -p /root/.wine/drive_c/VRisingServer/ \
    && cd /root/.wine/drive_c/steamcmd 


COPY entrypoint.sh .

RUN chmod +x /entrypoint.sh

EXPOSE 27015/udp
EXPOSE 27016/udp

ENTRYPOINT [ "/entrypoint.sh" ]