#!/bin/bash
# Paranoia Level
$(python <<EOF
import re
import os
out=re.sub('(#SecAction[\S\s]{7}id:900000[\s\S]*tx\.paranoia_level=1\")','SecAction \\\\\n  \"id:900000, \\\\\n   phase:1, \\\\\n   nolog, \\\\\n   pass, \\\\\n   t:none, \\\\\n   setvar:tx.paranoia_level='+os.environ['PARANOIA']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Executing Paranoia Level
$(python <<EOF
import re
import os
if "EXECUTING_PARANOIA" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{7}id:900001[\s\S]*tx\.executing_paranoia_level=1\")','SecAction \\\\\n  \"id:900001, \\\\\n   phase:1, \\\\\n   nolog, \\\\\n   pass, \\\\\n   t:none, \\\\\n   setvar:tx.executing_paranoia_level='+os.environ['EXECUTING_PARANOIA']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Inbound and Outbound Anomaly Score
$(python <<EOF
import re
import os
out=re.sub('(#SecAction[\S\s]{6}id:900110[\s\S]*tx\.outbound_anomaly_score_threshold=4\")','SecAction \\\\\n  \"id:900110, \\\\\n   phase:1, \\\\\n   nolog, \\\\\n   pass, \\\\\n   t:none, \\\\\n   setvar:tx.inbound_anomaly_score_threshold='+os.environ['ANOMALYIN']+','+'  \\\\\n   setvar:tx.outbound_anomaly_score_threshold='+os.environ['ANOMALYOUT']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Block request if number of arguments is too high
$(python <<EOF
import re
import os
if "MAX_NUM_ARGS" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{6}id:900300[\s\S]*tx\.max_num_args=255\")','SecAction \\\\\n \"id:900300, \\\\\n phase:1, \\\\\n nolog, \\\\\n pass, \\\\\n t:none, \\\\\n setvar:tx.max_num_args='+os.environ['MAX_NUM_ARGS']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Block request if the length of any argument name is too high
$(python <<EOF
import re
import os
if "ARG_NAME_LENGTH" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{6}id:900310[\s\S]*tx\.arg_name_length=100\")','SecAction \\\\\n \"id:900310, \\\\\n phase:1, \\\\\n nolog, \\\\\n pass, \\\\\n t:none, \\\\\n setvar:tx.arg_name_length='+os.environ['ARG_NAME_LENGTH']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Block request if the length of any argument value is too high
$(python <<EOF
import re
import os
if "ARG_LENGTH" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{6}id:900320[\s\S]*tx\.arg_length=400\")','SecAction \\\\\n \"id:900320, \\\\\n phase:1, \\\\\n nolog, \\\\\n pass, \\\\\n t:none, \\\\\n setvar:tx.arg_length='+os.environ['ARG_LENGTH']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Block request if the total length of all combined arguments is too high
$(python <<EOF
import re
import os
if "TOTAL_ARG_LENGTH" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{6}id:900330[\s\S]*tx\.total_arg_length=64000\")','SecAction \\\\\n \"id:900330, \\\\\n phase:1, \\\\\n nolog, \\\\\n pass, \\\\\n t:none, \\\\\n setvar:tx.total_arg_length='+os.environ['TOTAL_ARG_LENGTH']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Block request if the total length of all combined arguments is too high
$(python <<EOF
import re
import os
if "MAX_FILE_SIZE" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{6}id:900340[\s\S]*tx\.max_file_size=1048576\")','SecAction \\\\\n \"id:900340, \\\\\n phase:1, \\\\\n nolog, \\\\\n pass, \\\\\n t:none, \\\\\n setvar:tx.max_file_size='+os.environ['MAX_FILE_SIZE']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

# Block request if the total size of all combined uploaded files is too high
$(python <<EOF
import re
import os
if "COMBINED_FILE_SIZES" in os.environ: 
   out=re.sub('(#SecAction[\S\s]{6}id:900350[\s\S]*tx\.combined_file_sizes=1048576\")','SecAction \\\\\n \"id:900350, \\\\\n phase:1, \\\\\n nolog, \\\\\n pass, \\\\\n t:none, \\\\\n setvar:tx.combined_file_sizes='+os.environ['COMBINED_FILE_SIZES']+'\"',open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','r').read())
   open('/etc/apache2/modsecurity.d/owasp-crs/crs-setup.conf','w').write(out)
EOF
) && \

#PORT sets Virtual Host Port...
$(python <<EOF
import re
import os
out=re.sub('(VirtualHost\s\*:8001)','VirtualHost *:'+os.environ['PORT'],open('/etc/apache2/conf/httpd.conf','r').read())
open('/etc/apache2/conf/httpd.conf','w').write(out)
EOF
) && \

#... and Listen Port
$(python <<EOF
import re
import os
out=re.sub('(Listen\s+8001)','Listen            '+os.environ['PORT'],open('/etc/apache2/conf/httpd.conf','r').read())
open('/etc/apache2/conf/httpd.conf','w').write(out)
EOF
) && \


if [ ! -z $PROXY ]; then
  if [ $PROXY -eq 1 ]; then
    APACHE_ARGUMENTS='-D crs_proxy'
    if [ -z "$UPSTREAM" ]; then
      export UPSTREAM=$(/sbin/ip route | grep ^default | perl -pe 's/^.*?via ([\d.]+).*/$1/g'):81
    fi
  fi
fi


exec "$@" $APACHE_ARGUMENTS
