#!/bin/bash
apt-get update
apt-get install apcupsd -y

# Update apcupsd.conf configuration file
sed -i s/'UPSCABLE smart'/'UPSCABLE ether'/g /etc/apcupsd/apcupsd.conf
sed -i s/'UPSTYPE apcsmart'/'UPSTYPE net'/g /etc/apcupsd/apcupsd.conf
sed -i s/"DEVICE /dev/ttyS0"/'DEVICE 'IP_OF_UPS:3551''/g /etc/apcupsd/apcupsd.conf # <-- need more work
sed -i s/'NOLOGON disable'/'NOLOGON always'/g /etc/apcupsd/apcupsd.conf

# Change configured to yes
sed -i s/ISCONFIGURED=no/ISCONFIGURED=yes/g /etc/default/apcupsd

systemctl start apcupsd
systemctl status apcupsd
# When everything works fine enable the daemon
systemctl enable apcupsd
