#NOTE: needs to be run from this folder
rundir=$(pwd)

# Create user
sudo useradd --no-create-home --shell /bin/false node_exporter

#Download binary and install
cd /tmp
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.15.0/node_exporter-0.15.0.linux-amd64.tar.gz
tar -xzf node_exporter*
cp node_exporter-*/node_exporter /usr/local/bin
chown node_exporter:node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-*

#Prepare logging
mkdir /var/log/node_exporter
chown node_exporter:node_exporter /var/log/node_exporter

# Install init script
# init script requires daemonize
# Requires epel repo
yum install -y daemonize

cd $rundir
cp ../init-scripts/centos6/node_exporter /etc/init.d/
chmod +x /etc/init.d/node_exporter

chkconfig --add node_exporter
chkconfig node_exporter on
service node_exporter start
