## Custom Dockerfile
FROM consol/centos-xfce-vnc
ENV REFRESHED_AT 2019-09-02

# Switch to root user to install additional software
USER 0

# use mirrors
RUN mv /etc/yum.repos.d/CentOS-Base.repo{,.bak}\
    && mv /etc/yum.repos.d/epel.repo{,.bak}
COPY CentOS-Base.repo epel.repo /etc/yum.repos.d/
COPY xfce-wallpapers.jpg /usr/share/backgrounds/xfce/
 
## Install a gedit
RUN yum install -y gedit htop curl\
    && yum clean all

# modify wallpaper as default
RUN sed -i 's/\/headless\/.config\/bg_sakuli.png/\/usr\/share\/backgrounds\/xfce\/xfce-wallpapers.jpg/g'  $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# add custom user
ARG USERNAME
ARG PASSWORD
ENV USERNAME=${USERNAME:-impdev} PASSWORD=${PASSWORD:-impdev}
RUN echo "$USERNAME"
RUN useradd -d $HOME --shell /bin/bash --user-group --groups wheel ${USERNAME}\
    && echo "$USERNAME:$PASSWORD" | chpasswd
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Source global definitions
RUN echo "if [ -f /etc/bashrc ]; then  . /etc/bashrc; fi" >> $HOME/.bashrc \
    && echo "alias ll='ls -alF'" >> $HOME/.bashrc

## switch back to default user
USER 1000
