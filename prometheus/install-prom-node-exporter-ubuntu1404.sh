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

cd $rundir
cp ../init-scripts/ubuntu1404/node_exporter.conf /etc/init/

service node_exporter start
