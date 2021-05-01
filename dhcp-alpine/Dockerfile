FROM alpine:edge
LABEL maintainer="fu1983@hotmail.com"
# webproc release settings
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/v0.4.0/webproc_0.4.0_linux_amd64.gz
# fetch dnsmasq and webproc binary
RUN apk update \
	&& apk --no-cache add dhcp \
	&& apk add --no-cache --virtual .build-deps curl \
	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc \
	&& apk del .build-deps

EXPOSE 67/udp 67/tcp 8080/tcp

RUN ["touch", "/var/lib/dhcp/dhcpd.leases"]

#run!
ENTRYPOINT ["webproc","-c","/etc/dhcp/dhcpd.conf","--","/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
