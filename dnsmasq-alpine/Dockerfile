FROM alpine:edge
LABEL maintainer="fu1983@hotmail.com"
# webproc release settings
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/v0.4.0/webproc_0.4.0_linux_amd64.gz
# fetch dnsmasq and webproc binary
RUN apk update \
	&& apk --no-cache add dnsmasq \
	&& apk add --no-cache --virtual .build-deps curl \
	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc \
	&& apk del .build-deps
#configure dnsmasq
RUN mkdir -p /etc/default/
RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf
EXPOSE 53/tcp 53/udp 67/tcp 67/udp 8080/tcp
#run!
ENTRYPOINT ["webproc","-c","/etc/dnsmasq.conf","--","dnsmasq","--no-daemon"]
