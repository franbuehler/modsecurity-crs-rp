#!/bin/bash
#PARANOIA sets paranoia_level
python -c "import re;import os;out=re.sub('(paranoia_level=1\")','paranoia_level='+os.environ['PARANOIA']+'\"',open('/etc/httpd/conf/httpd.conf','r').read());open('/etc/httpd/conf/httpd.conf','w').write(out)" && \
#BACKEND sets backend to which we proxy
python -c "import re;import os;out=re.sub('(http://localhost:8002)',os.environ['BACKEND'],open('/etc/httpd/conf/httpd.conf','r').read());open('/etc/httpd/conf/httpd.conf','w').write(out)" && \
#ANOMALYIN sets inbound_anomaly_score_threshold
python -c "import re;import os;out=re.sub('(inbound_anomaly_score_threshold=5)','inbound_anomaly_score_threshold='+os.environ['ANOMALYIN'],open('/etc/httpd/conf/httpd.conf','r').read());open('/etc/httpd/conf/httpd.conf','w').write(out)" && \
#ANOMALYOUT sets outbound_anomaly_score_threshold
python -c "import re;import os;out=re.sub('(outbound_anomaly_score_threshold=4)','outbound_anomaly_score_threshold='+os.environ['ANOMALYOUT'],open('/etc/httpd/conf/httpd.conf','r').read());open('/etc/httpd/conf/httpd.conf','w').write(out)" && \
#PORT sets Virtual Host Port...
python -c "import re;import os;out=re.sub('(VirtualHost\s\*:8001)','VirtualHost *:'+os.environ['PORT'],open('/etc/httpd/conf/httpd.conf','r').read());open('/etc/httpd/conf/httpd.conf','w').write(out)" && \
#... and Listen Port
python -c "import re;import os;out=re.sub('(Listen\s+8001)','Listen            '+os.environ['PORT'],open('/etc/httpd/conf/httpd.conf','r').read());open('/etc/httpd/conf/httpd.conf','w').write(out)" && \

	exec "$@"
