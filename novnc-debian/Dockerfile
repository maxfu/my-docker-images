# Using Debian Stable base image and VNC

FROM debian:stable
MAINTAINER max.fu <fu1983@hotmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="desktopuser"
ENV UID=1000
ENV GID=0
ENV HOME=/home/${USER}
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ARG vnc_password=""
EXPOSE 5901 6080

ADD xstartup ${HOME}/.vnc/

RUN useradd -g ${GID} -u ${UID} -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends sudo git curl wget ca-certificates python3 python3-numpy fluxbox procps && \
    apt-get install -y --no-install-recommends tigervnc-standalone-server tigervnc-common && \
    /bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    wget https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz -O /tmp/noVNC.tar.gz && \
    tar -zxvf /tmp/noVNC.tar.gz -C /opt && \
    git clone https://github.com/novnc/websockify /opt/noVNC-1.2.0/utils/websockify && \
    rm -rf /opt/noVNC-1.2.0/utils/websockify/.git /tmp/noVNC.tar.gz && \
    mv /opt/noVNC-1.2.0/vnc_lite.html /opt/noVNC-1.2.0/index.html && \
    sed -i 's/<title>noVNC<\/title>/<title>Debian Stable<\/title>/g' /opt/noVNC-1.2.0/index.html && \
    apt-get purge -y git-man git && \
    apt-get autoremove -y && \
    apt-get clean

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority /var/log/baidunetdisk.log

RUN chown -R ${UID}:${GID} ${HOME}
RUN chown ${UID}:${GID} /var/log/baidunetdisk.log
RUN chmod 755 ${HOME}/.vnc/xstartup
RUN chmod 600 ${HOME}/.vnc/passwd

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get install -y --no-install-recommends dbus-x11 fcitx-module-dbus fcitx-ui-classic fcitx-googlepinyin locales && \
    apt-get install -y --no-install-recommends libgbm1 libasound2 fonts-wqy-microhei xdg-utils desktop-file-utils midori xterm && \
    last_version=$(curl -s "https://pan.baidu.com/disk/cmsdata?do=client"|grep -i -o "https:[0-9a-z/\\\.\_\-]*\.deb"|sed 's/\\//g') && \
    wget ${last_version} -O /tmp/baidunetdisk_linux.deb && \
    apt-get install -y -f --no-install-recommends /tmp/baidunetdisk_linux.deb && \
    apt-get clean && rm -f /tmp/baidunetdisk_linux.deb

RUN echo "locales locales/default_environment_locale select zh_CN.UTF-8" | debconf-set-selections && \
    echo "locales locales/locales_to_be_generated multiselect zh_CN.UTF-8 UTF-8" | debconf-set-selections && \
    rm "/etc/locale.gen" && \
    dpkg-reconfigure --frontend noninteractive locales && \
    locale-gen zh_CN.UTF-8

ENV LC_ALL "zh_CN.UTF-8"

USER ${USER}
WORKDIR ${HOME}

RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc

RUN mkdir -p ${HOME}/.fluxbox
RUN /bin/echo -e "session.screen0.toolbar.placement: TopCenter" >> ${HOME}/.fluxbox/init
RUN /bin/echo -e "session.screen0.workspaces:     1 ">> ${HOME}/.fluxbox/init

RUN /bin/echo -e "[begin] (fluxbox)" > ${HOME}/.fluxbox/menu
RUN /bin/echo -e "[exec] (xTerm) { x-terminal-emulator } <>" >> ${HOME}/.fluxbox/menu
RUN /bin/echo -e "[exec] (Internet Browser) { midori } <>" >> ${HOME}/.fluxbox/menu
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
RUN /bin/echo -e "/opt/noVNC-1.2.0/utils/launch.sh --listen 6080 --vnc 127.0.0.1:5901 &"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "sudo mkdir -p ${HOME}/baidunetdiskdownload/"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "sudo chmod -R a=rwx ${HOME}/baidunetdiskdownload/"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "while true; do" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    /opt/baidunetdisk/baidunetdisk --no-sandbox >> /var/log/baidunetdisk.log 2>&1" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "done" >> ${HOME}/.vnc/xstartup
