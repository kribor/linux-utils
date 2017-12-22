#!/usr/bin/env bash

# Prerequisites (tested as is, all may not be necessary)
# Same OS (tested on ubuntu 14.04), same zimbra version installed on prod (can be found in .install_history)
# State: zimbra startable but old data, same host name on new server
# RUNAS: root
# NOTE: this script is not fully automated and you will need to interact at several points.

# Stop zimbra
su -l -c "zmcontrol stop" zimbra

echo "Zimbra Stopped! "
echo "Please complete rsync from backup server! (2-restore-backup-server.sh)"
echo "Press [enter] when rsync completes, ctrl+c to exit"
read foo

#Fix permissions
chown -R zimbra:zimbra /opt/zimbra
/opt/zimbra/libexec/zmfixperms

# Restore LDAP config - usually not required
#su  -l -c "ldap stop" zimbra
#cd /opt/zimbra/data/ldap
#rm -rf config.bak
#mv config config.bak
#mkdir config
#chown -R zimbra:zimbra config
#chown -R zimbra:zimbra /backup/ldap-config.bak
#su -l -c "/opt/zimbra/libexec/zmslapadd -c /backup/ldap-config.bak" zimbra
#su -l -c "ldap start" zimbra

# Restore ldap DB, required in my backup setup
echo "Restoring ldap backup (skipping config and access log)"
su -l -c "ldap stop" zimbra
cd /opt/zimbra/data/ldap
rm -rf mdb.old
mv mdb mdb.old
mkdir -p mdb/db
chown -R zimbra:zimbra mdb
chown -R zimbra:zimbra /backup/ldap.bak
su -l -c "/opt/zimbra/libexec/zmslapadd /backup/ldap.bak" zimbra
su -l -c "ldap start" zimbra

su -l -c "zmcontrol start" zimbra
