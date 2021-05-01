FROM alpine:edge

LABEL maintainer="fu1983@hotmail.com"

COPY smb-base.conf /etc/samba/
COPY functions.sh /etc/samba/functions.sh
COPY bashrc /root/.bashrc

EXPOSE 445

RUN apk update
RUN apk --no-cache add samba bash
RUN touch /etc/samba/firstrun
RUN mkdir /share

CMD bash
