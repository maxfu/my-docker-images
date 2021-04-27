# Using Debian Stable base image and VNC

FROM debian:stable
MAINTAINER max.fu <fu1983@hotmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="kodi"
ENV UID=1000
ENV GID=0
ENV HOME=/home/${USER}
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ARG vnc_password=""
EXPOSE 6090

ADD xstartup ${HOME}/.vnc/

RUN useradd -g ${GID} -u ${UID} -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get dist-upgrade -y
RUN apt-get install -y --no-install-recommends sudo git curl wget ca-certificates python3 python3-numpy fluxbox procps
RUN apt-get install -y --no-install-recommends tigervnc-standalone-server tigervnc-common
RUN /bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
RUN wget https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz -O /tmp/noVNC.tar.gz
RUN tar -zxvf /tmp/noVNC.tar.gz -C /opt
RUN git clone https://github.com/novnc/websockify /opt/noVNC-1.2.0/utils/websockify
RUN rm -rf /opt/noVNC-1.2.0/utils/websockify/.git /tmp/noVNC.tar.gz
RUN mv /opt/noVNC-1.2.0/vnc_lite.html /opt/noVNC-1.2.0/index.html
RUN sed -i 's/<title>noVNC<\/title>/<title>Debian Stable<\/title>/g' /opt/noVNC-1.2.0/index.html
RUN apt-get purge -y git-man git
RUN apt-get autoremove -y
RUN apt-get clean

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority /var/log/kodi.log

RUN chown -R ${UID}:${GID} ${HOME}
RUN chown ${UID}:${GID} /var/log/kodi.log
RUN chmod 755 ${HOME}/.vnc/xstartup
RUN chmod 600 ${HOME}/.vnc/passwd

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get install -y --no-install-recommends dbus-x11 fcitx-module-dbus fcitx-ui-classic fcitx-googlepinyin locales
RUN apt-get install -y --no-install-recommends fonts-wqy-microhei xdg-utils desktop-file-utils kodi xterm

USER ${USER}
WORKDIR ${HOME}

RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc

RUN mkdir -p ${HOME}/.fluxbox
RUN /bin/echo -e "session.screen0.toolbar.placement: TopCenter" >> ${HOME}/.fluxbox/init
RUN /bin/echo -e "session.screen0.workspaces:     1 ">> ${HOME}/.fluxbox/init

RUN /bin/echo -e "[begin] (fluxbox)" > ${HOME}/.fluxbox/menu
RUN /bin/echo -e "[exec] (Terminal) { x-terminal-emulator } <>" >> ${HOME}/.fluxbox/menu
RUN /bin/echo -e "[exec] (Kodi) { kodi } <>" >> ${HOME}/.fluxbox/menu
RUN /bin/echo -e "[include] (/etc/X11/fluxbox/fluxbox-menu)" >> ${HOME}/.fluxbox/menu
RUN /bin/echo -e "[end]" >> ${HOME}/.fluxbox/menu

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nfbsetroot -solid gray"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fluxbox &"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'export GTK_IM_MODULE=fcitx' >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'export QT_IM_MODULE=fcitx' >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'export XMODIFIERS="@im=fcitx"' >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "sleep 3"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fcitx"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "/opt/noVNC-1.2.0/utils/launch.sh --listen 6090 --vnc 127.0.0.1:5901 &"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "while true; do" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    kodi >> /var/log/kodi.log 2>&1" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "done" >> ${HOME}/.vnc/xstartup
