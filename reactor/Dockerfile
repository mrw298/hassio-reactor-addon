ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL \
  io.hass.version="$BUILD_VERSION" \
  io.hass.type="addon" \
  io.hass.arch="$BUILD_ARCH"

RUN \
  apk add --no-cache bash supervisor nginx; \
  rm -rf /var/cache/apk/*

SHELL ["/bin/bash", "-c"]

COPY run.sh /opt/reactor/run.sh
RUN chmod a+x run.sh

ADD nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8099

ADD supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

#CMD [ "/bin/bash", "-c", "/opt/reactor/run.sh" ]
