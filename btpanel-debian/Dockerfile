FROM debian:stable
MAINTAINER max.fu <fu1983@hotmail.com>

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y nano curl procps kmod

RUN curl -sSO http://download.bt.cn/install/install_panel.sh
RUN echo 'y' | bash install_panel.sh
RUN bt stop
RUN echo '/btpanel' > /www/server/panel/data/admin_path.pl
RUN echo 'btpanel' | bt 6
RUN echo 'btpanel' | bt 5

EXPOSE 80 443 888 8888
