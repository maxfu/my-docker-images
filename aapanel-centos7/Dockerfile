FROM centos:centos7
MAINTAINER max.fu <fu1983@hotmail.com>

RUN yum update -y
RUN yum install -y wget nano iproute

RUN wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh
RUN echo 'y' | bash install.sh
RUN bt stop
RUN /www/server/panel/pyenv/bin/python3.7 -m pip install --upgrade pip
RUN echo '/' > /www/server/panel/data/admin_path.pl
RUN echo 'aapanel' | bt 6
RUN echo 'aapanel' | bt 5

EXPOSE 80 443 888 8888

ENTRYPOINT bt start && tail -f /www/server/panel/logs/error.log
