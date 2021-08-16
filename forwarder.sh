#!/bin/bash

sudo /opt/splunkforwarder/bin/splunk status
if [ $? -ne 0 ]
then 
    rpm -qi splunkforwarder-8.2.1-ddff1c41e5cf.x86_64
    if [ $? -ne 0 ]
    then
        wget https://d7wz6hmoaavd0.cloudfront.net/products/universalforwarder/releases/8.2.1/linux/splunkforwarder-8.2.1-ddff1c41e5cf-linux-2.6-x86_64.rpm
        sudo yum install -y splunkforwarder-8.2.1-ddff1c41e5cf-linux-2.6-x86_64.rpm
    else
        continue 
    fi
    cd /opt/splunkforwarder/bin
    sudo ./splunk start --accept-license --seed-passwd 1q2w3e4r
    sudo ./splunk enable boot-start

    sudo ./splunk add forward-server 10.66.42.160:9997 -auth admin:1q2w3e4r
    sudo ./splunk add monitor /var/log/nginx/
    sudo ./splunk add monitor /var/log/messages
    sudo ./splunk add monitor /var/log/audit/
    sudo ./splunk add monitor /var/log/secure 
    echo "done" > /tmp/splunk_statux.txt
else
    exit 0
fi
exit 0
