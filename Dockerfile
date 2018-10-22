FROM owasp/modsecurity-crs:v3.1
LABEL maintainer="franziska.buehler@owasp.org"

ENV PARANOIA=1
ENV ANOMALYIN=5
ENV ANOMALYOUT=4
ENV PORT=8001
ENV BACKEND=http://172.17.0.1:8000

COPY httpd.conf /etc/apache2/conf/httpd.conf
COPY 403.html /etc/apache2/htdocs/error/
COPY docker-entrypoint.sh /

RUN mkdir /var/log/apache2/audit \
  && chown www-data:www-data -R /var/log/apache2/ /docker-entrypoint.sh /etc/apache2/conf/httpd.conf /etc/apache2/htdocs/

EXPOSE 8001

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apachectl", "-f", "/etc/apache2/conf/httpd.conf", "-D", "FOREGROUND"]
#CMD ["httpd", "-k", "start", "-f", "/etc/httpd/conf/httpd.conf", "-D", "FOREGROUND"]

USER www-data
