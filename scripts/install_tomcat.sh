sudo yum install wget -y
sudo yum install fontconfig java-11-openjdk -y
cd /opt
sudo useradd tomcat 
sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.13/bin/apache-tomcat-10.1.13.tar.gz
sudo tar -xvzf apache-tomcat-10.1.13.tar.gz 
sudo mv apache-tomcat-10.1.13 tomcat_10.1.13
sudo chown -R tomcat:tomcat tomcat_10.1.13/
sudo ln -s /opt/tomcat_10.1.13/bin/startup.sh /usr/local/bin/tomcatup
sudo ln -s /opt/tomcat_10.1.13/bin/shutdown.sh /usr/local/bin/tomcatdown
#sudo sed -i '21s/^/<!-- /' "/opt/tomcat_10.1.13/webapps/host-manager/META-INF/context.xml"
#sudo sed -i '22s/$/ -->/' "/opt/tomcat_10.1.13/webapps/host-manager/META-INF/context.xml"
#file_path="/opt/tomcat_10.1.13/conf/tomcat-users.xml"
#user_info="<role rolename=\"admin-gui,manager-gui,manager,admin\"/>
#<user username=\"admin\" password=\"tomcat\" roles=\"manager-gui,admin-gui,manager,admin\"/>"
echo $user_info | sudo tee -a $file_path
sudo su - tomcat -c "tomcatdown"
sudo su - tomcat -c "tomcatup"