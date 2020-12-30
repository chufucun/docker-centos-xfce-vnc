## Custom Dockerfile
FROM consol/centos-xfce-vnc
ENV REFRESHED_AT 2019-09-02

# Switch to root user to install additional software
USER 0

# Use mirrors
COPY CentOS-Base.repo epel.repo /etc/yum.repos.d/
COPY xfce-wallpapers.jpg /usr/share/backgrounds/xfce/
 
## Install a gedit
RUN yum install -y gedit htop curl git openssh-server\
    && yum clean all

# Modify timezone and wallpaper
RUN rm -v /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime\
   && sed -i 's/\/headless\/.config\/bg_sakuli.png/\/usr\/share\/backgrounds\/xfce\/xfce-wallpapers.jpg/g'  $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Add custom user
ARG USERNAME
ARG PASSWORD
ENV USERNAME=${USERNAME:-impdev} PASSWORD=${PASSWORD:-impdev}
RUN echo "$USERNAME"
RUN useradd -d $HOME --shell /bin/bash --user-group --groups wheel ${USERNAME}\
    && echo "$USERNAME:$PASSWORD" | chpasswd
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN unset PASSWORD

# Source global definitions
RUN echo "if [ -f /etc/bashrc ]; then  . /etc/bashrc; fi" >> $HOME/.bashrc \
    && echo "alias ll='ls -alF'" >> $HOME/.bashrc

## Switch back to default user
USER 1000
