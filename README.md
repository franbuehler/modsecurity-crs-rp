# modsecurity-crs-rp

This Docker image inherits from the official OWASP Core Rule Set Docker image (ModSecurity + Core Rule Set) and adds some configurable variables and an Apache Reverse Proxy configuration.

## Environment Variables
* PARANOIA: paranoia_level
* EXECUTING_PARANOIA: executing_paranoia_level
* ANOMALYIN: inbound_anomaly_score_threshold
* ANOMALYOUT: outbound_anomaly_score_threshold
* MAX_NUM_ARGS: max_num_args
* ARG_NAME_LENGTH: arg_name_length
* ARG_LENGTH: arg_length
* TOTAL_ARG_LENGTH: total_arg_length
* MAX_FILE_SIZE: max_file_size
* COMBINED_FILE_SIZES: combined_file_sizes


See https://coreruleset.org/ for further information.

* BACKEND: application backend
* PORT: listening port of apache, this port must be exposed: --expose

## Examples
```
docker run -dt --name apachecrsrp -e PARANOIA=1 -e \
ANOMALYIN=5 -e ANOMALYOUT=4 -e BACKEND=http://172.17.0.1:8000 \
-e PORT=8001 --expose 8001 franbuehler/modsecurity-crs-rp
```


```
docker run -dti --name apachecrsrp -p 1.2.3.4:80:8080 -e PARANOIA=1 \
-e EXECUTING_PARANOIA=3 -e ANOMALYIN=10 -e ANOMALYOUT=5 -e MAX_NUM_ARGS=255 \
-e ARG_NAME_LENGTH=100 -e ARG_LENGTH=400 -e TOTAL_ARG_LENGTH=64000 \
-e MAX_FILE_SIZE=1048576 -e COMBINED_FILESIZES=1048576 \
-e BACKEND=http://192.168.192.57:8000 -e PORT=8080 franbuehler/modsecurity-crs-rp
```


