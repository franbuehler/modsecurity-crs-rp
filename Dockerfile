FROM owasp/modsecurity-crs:v3.1
LABEL maintainer="franziska.buehler.schmocker@gmail.com"

ENV PARANOIA=1
ENV ANOMALYIN=5
ENV ANOMALYOUT=4
ENV PORT=8001
ENV BACKEND=http://172.17.0.1:8000

COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY 403.html /etc/httpd/htdocs/error/
COPY docker-entrypoint.sh /

RUN mkdir -p /etc/httpd/htdocs \
  && mkdir /var/log/httpd/audit/ \
  && chown apache:apache -R /var/log/httpd/ /docker-entrypoint.sh /etc/httpd/conf/httpd.conf /etc/httpd/htdocs/

EXPOSE 8001

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["httpd", "-k", "start", "-f", "/etc/httpd/conf/httpd.conf", "-D", "FOREGROUND"]

USER apache
