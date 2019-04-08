FROM owasp/modsecurity-crs:v3.1
LABEL maintainer="franziska.buehler@owasp.org"

ENV PARANOIA=1
ENV ANOMALYIN=5
ENV ANOMALYOUT=4
ENV PORT=8001
ENV BACKEND=http://172.17.0.1:8000

COPY httpd.conf /etc/apache2/conf/httpd.conf
COPY 403.html /var/www/html/error/
COPY CRS-logo-full_size-512x257.png /var/www/html/error/
COPY docker-entrypoint.sh /

RUN mkdir /var/log/apache2/audit /var/lock/apache2 \
    && chmod -R g=u /etc/apache2/modsecurity.d/ /etc/apache2/conf/httpd.conf /var/lock/ /var/run/ /var/log/ /var/www/html/ \
    && chown www-data:root -R /etc/apache2/modsecurity.d/ /etc/apache2/conf/httpd.conf /var/lock/ /var/run/ /var/log/ /var/www/html/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apachectl", "-f", "/etc/apache2/conf/httpd.conf", "-D", "FOREGROUND"]

USER www-data
