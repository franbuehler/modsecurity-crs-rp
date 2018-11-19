# modsecurity-crs-rp

This Docker image inherits from the official OWASP Core Rule Set Docker image (ModSecurity + Core Rule Set) and adds some configurable variables and an Apache Reverse Proxy configuration.

## Environment Variables
* PARANOIA: paranoia_level
* EXECUTING_PARANOIA: executing_paranoia_level
* ENFORCE_BODYPROC_URLENCODED: enforce_bodyproc_urlencoded
* ANOMALYIN: inbound_anomaly_score_threshold
* ANOMALYOUT: outbound_anomaly_score_threshold
* ALLOWED_METHODS: allowed_methods
* ALLOWED_REQUEST_CONTENT_TYPE: allowed_request_content_type
* ALLOWED_REQUEST_CONTENT_TYPE_CHARSET: allowed_request_content_type_charset
* ALLOWED_HTTP_VERSIONS: allowed_http_versions
* RESTRICTED_EXTENSIONS: restricted_extensions
* RESTRICTED_HEADERS: restricted_headers
* STATIC_EXTENSIONS: static_extensions
* MAX_NUM_ARGS: max_num_args
* ARG_NAME_LENGTH: arg_name_length
* ARG_LENGTH: arg_length
* TOTAL_ARG_LENGTH: total_arg_length
* MAX_FILE_SIZE: max_file_size
* COMBINED_FILE_SIZES: combined_file_sizes


See https://coreruleset.org/ for further information.

* BACKEND: application backend
* PORT: listening port of apache

## ModSecurity Tuning

There are two possible ways to pass ModSecurity tuning rules to the container:

* To map the ModSecurity tuning file(s) via volumes into the container during the run command 
* To copy the ModSecurity tuning file(s) into the created container and then start the container

##### Map ModSecurity tuning file via volume

```
docker run -dti \
   --name apachecrsrp \
   -p 1.2.3.4:80:8001 \
   -v /path/to/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf:/etc/apache2/modsecurity.d/owasp-crs/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf \
   -v /path/to/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf:/etc/apache2/modsecurity.d/owasp-crs/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf \
   franbuehler/modsecurity-crs-rp:v3.1
```

##### Copy ModSecurity tuning file into created container

This example can be helpful when no volume mounts are possible (some CI pipelines).

```
docker create -ti --name apachecrsrp \
   -p 1.2.3.4:80:8001 \
   franbuehler/modsecurity-crs-rp:v3.1

docker cp /path/to/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf \
   apachecrsrp:/etc/apache2/modsecurity.d/owasp-crs/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf

docker start apachecrsrp
```



## Environmant variables examples


##### Full example with all possible environment variables

```
docker run -dti --name apachecrsrp -p 0.0.0.0:80:8001 \
   -e PARANOIA=1 \
   -e EXECUTING_PARANOIA=2 \
   -e ENFORCE_BODYPROC_URLENCODED=1 \
   -e ANOMALYIN=10 \
   -e ANOMALYOUT=5 \
   -e ALLOWED_METHODS="GET POST PUT" \
   -e ALLOWED_REQUEST_CONTENT_TYPE_CHARSET="utf-8|iso-8859-1" \
   -e ALLOWED_HTTP_VERSIONS="HTTP/1.1 HTTP/2 HTTP/2.0" \
   -e RESTRICTED_EXTENSIONS=".cmd/ .com/ .config/ .dll/" \
   -e RESTRICTED_HEADERS="/proxy/ /if/" \
   -e STATIC_EXTENSIONS="/.jpg/ /.jpeg/ /.png/ /.gif/" \
   -e MAX_NUM_ARGS=128 \
   -e ARG_NAME_LENGTH=50 \
   -e ARG_LENGTH=200 \
   -e TOTAL_ARG_LENGTH=6400 \
   -e MAX_FILE_SIZE=100000 \
   -e COMBINED_FILE_SIZES=1000000 \
   -e BACKEND=http://192.168.192.57:8000 \
   -e PORT=8001 \
   franbuehler/modsecurity-crs-rp
```


##### Example run command for CI integration when no port mapping is possible

```
docker run -dt --name apachecrsrp \
   -e PARANOIA=1 \
   -e ANOMALYIN=5 \
   -e ANOMALYOUT=4 \
   -e BACKEND=http://172.17.0.1:8000 \
   -e PORT=8001 
   --expose 8001 
   franbuehler/modsecurity-crs-rp
```


##### Just another example

```
docker run -dti --name apachecrsrp \
   -p 1.2.3.4:80:8080 \
   -e PARANOIA=1 \
   -e EXECUTING_PARANOIA=3 \
   -e ANOMALYIN=10 \
   -e ANOMALYOUT=5 \
   -e MAX_NUM_ARGS=255 \
   -e ARG_NAME_LENGTH=100 \
   -e ARG_LENGTH=400 \
   -e TOTAL_ARG_LENGTH=64000 \
   -e MAX_FILE_SIZE=1048576 \
   -e COMBINED_FILESIZES=1048576 \
   -e BACKEND=http://192.168.192.57:8000 \
   -e PORT=8080 franbuehler/modsecurity-crs-rp
```


