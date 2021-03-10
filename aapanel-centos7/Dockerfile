FROM centos:centos7
MAINTAINER max.fu <fu1983@hotmail.com>

RUN yum update -y
RUN yum install -y wget nano iproute

RUN wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh
RUN echo 'y' | bash install.sh
RUN bt stop
RUN echo '/aapanel' > /www/server/panel/data/admin_path.pl
RUN echo 'aapanel' | bt 6
RUN echo 'aapanel' | bt 5
RUN echo '18888' | bt 8

EXPOSE 80 443 888 18888
