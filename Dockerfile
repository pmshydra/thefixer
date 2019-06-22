FROM alpine:3.7
MAINTAINER PMSHydra

RUN apk add --no-cache curl jq dos2unix
VOLUME /root/
COPY docker-entrypoint.sh /root/
RUN chmod +x /root/docker-entrypoint.sh && dos2unix /root/docker-entrypoint.sh
ENTRYPOINT ["/root/docker-entrypoint.sh"]

HEALTHCHECK --interval=5s CMD /root/docker-entrypoint.sh checkcontainer

CMD ["restart"]