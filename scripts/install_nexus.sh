#!/bin/bash
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y wget
cd /opt
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar -xvf latest-unix.tar.gz
sudo mv nexus-* nexus3
sudo adduser nexus
sudo chown -R nexus:nexus /opt/nexus3
sudo chown -R nexus:nexus /opt/sonatype-work
sudo sed -i 's|#run_as_user=""|run_as_user="nexus"|' /opt/nexus3/bin/nexus.rc
sudo ln -s /opt/nexus3/bin/nexus /etc/init.d/nexus
cd /etc/init.d && sudo chkconfig --add nexus
sudo chkconfig nexus on
sudo service nexus start
sudo service nexus status
nohup sudo python3 -m http.server --directory /opt/sonatype-work/nexus3/  80 &