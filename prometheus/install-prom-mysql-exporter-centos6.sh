#NOTE: needs to be run from this folder
rundir=$(pwd)

# Create user
sudo useradd --no-create-home --shell /bin/false mysqld_exporter

#Download binary and install
cd /tmp
curl -LO https://github.com/prometheus/mysqld_exporter/releases/download/v0.10.0/mysqld_exporter-0.10.0.linux-amd64.tar.gz
tar -xzf mysqld_exporter*
cp mysqld_exporter-*/mysqld_exporter /usr/local/bin
chown mysqld_exporter:mysqld_exporter /usr/local/bin/mysqld_exporter
rm -rf mysqld_exporter-*

#Prepare logging
mkdir /var/log/mysqld_exporter
chown mysqld_exporter:mysqld_exporter /var/log/mysqld_exporter

# Install init script
# init script requires daemonize
# Requires epel repo
yum install -y daemonize

cd $rundir
cp ../init-scripts/centos6/mysqld_exporter /etc/init.d/
chmod +x /etc/init.d/mysqld_exporter

chkconfig --add mysqld_exporter
chkconfig mysqld_exporter on
service mysqld_exporter start
