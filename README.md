# modsecurity-crs-rp

This Docker image inherits from the official OWASP Core Rule Set Docker image (ModSecurity + Core Rule Set) and adds some configurable variables and an Apache Reverse Proxy configuration.

## Environment Variables
PARANOIA: paranoia_level
ANOMALYIN: inbound_anomaly_score_threshold
ANOMALYOUT: outbound_anomaly_score_threshold
See https://coreruleset.org/

BACKEND: application backend
PORT: listening port of apache, this port must be exposed: --expose

## Example
```
docker run -dt --name apachecrsrp -e PARANOIA=1 -e \
ANOMALYIN=5 -e ANOMALYOUT=4 -e BACKEND=http://172.17.0.1:8000 \
-e PORT=8001 --expose 8001 franbuehler/modsecurity-crs-rp
```
