FROM owasp/modsecurity-crs:v3.1
LABEL maintainer="franziska.buehler.schmocker@gmail.com"

ENV PARANOIA=1
ENV ANOMALYIN=5
ENV ANOMALYOUT=4
ENV PORT=8001
ENV BACKEND=http://172.17.0.1:8000

RUN mkdir -p /etc/httpd/htdocs \
    mkdir /var/log/httpd/audit/ \
    chown apache -R /var/log/httpd/

COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY docker-entrypoint.sh /

USER apache

EXPOSE 8001

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["httpd", "-k", "start", "-f", "/etc/httpd/conf/httpd.conf", "-D", "FOREGROUND"]

