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
RUN apt-get install -y vim 
# pstree取得のため
RUN apt-get install -y psmisc 
RUN apt-get install -y language-pack-ja-base language-pack-ja
RUN apt-get install manpages-ja

# 下ではインストールできなかった。。。
# RUN apt install -y imagemagick < /home/$USERNAME/input-install-imagemagick.txt 
RUN echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME/
ENV LANG=ja_JP.UTF-8