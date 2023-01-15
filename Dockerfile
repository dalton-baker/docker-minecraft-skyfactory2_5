FROM openjdk:8

MAINTAINER Dalton Baker <dalton.s.baker@gmail.com>

RUN apt-get install -y wget unzip && \
 addgroup --gid 1234 minecraft && \
 adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

COPY minecraft_server.1.7.10.jar /tmp/feed-the-beast/minecraft_server.1.7.10.jar

RUN cd /tmp/feed-the-beast && \
 wget -c https://mediafilez.forgecdn.net/files/3559/130/FTB_Presents_SkyFactory_2_5_Server_2_5_9.zip -O SkyFactory_2_5_Server.zip -O SkyFactory_2_5_Server.zip && \
 unzip SkyFactory_2_5_Server.zip -d /tmp/feed-the-beast && \
 chmod -R 777 /tmp/feed-the-beast && \
 chown -R minecraft /tmp/feed-the-beast && \
 cd /tmp/feed-the-beast && bash -x Install.sh && \ 
 chmod -R 777 /tmp/feed-the-beast && \
 chown -R minecraft /tmp/feed-the-beast

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER minecraft

VOLUME /data
WORKDIR /data

EXPOSE 25565

CMD ["/start.sh"]

ENV MOTD "A Minecraft (SkyFactory 2.5.9) Server Powered by Docker"
ENV LEVEL world
ENV JVM_OPTS "-Xms4048m -Xmx4048m"