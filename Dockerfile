FROM ubuntu
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user

COPY qdata/ /home/$USERNAME/qdata/
RUN groupadd -g $GID $GROUPNAME && \
  useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
  echo $USERNAME:$PASSWORD | chpasswd
RUN chown -R user:user /home/$USERNAME/
# COPY --chmod=777 input-install-imagemagick.txt /home/$USERNAME/

RUN apt-get update && apt-get install -y sudo
RUN apt-get install -y bc
RUN apt-get update && yes | unminimize
RUN apt-get install -y man
RUN apt-get install -y gawk
RUN apt-get install -y gawk
# RUN apt-get update && apt install -y git
# 地域を答えなければ行けないので、下だけでは動かないかも
# RUN apt install -y imagemagick < /home/$USERNAME/input-install-imagemagick.txt 
RUN echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME/