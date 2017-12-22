#!/usr/bin/env bash

# Required env vars to set
# zimbra_backup_root=/var/backup/zimbra # No trailing slash
# ldap_backup_dir=/var/backup/ldap
# target_host= IP #Requires root access

# Recommended to have ssh keys set up so that password input isn't necessary

rsync -avz $ldap_backup_dir root@$target_host:/backup/
rsync -avz $zimbra_backup_root root@$target_host:/opt/