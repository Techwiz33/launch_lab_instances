#!/usr/bin/bas
# Script to install and configure Tomcat server

# Step 1: Updating and Installing Dependencies
if ! (yum update -y && yum install wget -y); then
    echo "Failed to update or install wget. Please check your system configuration." >&2
    exit 1
fi

# Step 2: Installing Java
if ! yum install fontconfig java-11-openjdk -y &> /dev/null; then
    echo "Failed to install Java." >&2
    exit 1
fi

# Step 3: Checking Existing Tomcat Installation
if [[ -d "/opt/tomcat${tom_m_ver}" ]]; then
    read -p "Tomcat is already installed. Do you want to reinstall? [y/n]: " reinstall
    if [[ $reinstall != "y" ]]; then
        echo "Script terminated by user."
        exit 0
    fi
    rm -rf "/opt/tomcat${tom_m_ver}"
fi

# Step 4: Downloading and Installing Tomcat
read -p "Enter Tomcat version to install (e.g., 9.0.48): " req_tom_ver
read -p "Enter the desired port number (default: 8089): " port_number

port_number=${port_number:-8089}

tom_m_ver=$(echo "$req_tom_ver" | cut -c 1)
url="https://dlcdn.apache.org/tomcat/tomcat-${tom_m_ver}/v${req_tom_ver}/bin/apache-tomcat-${req_tom_ver}.tar.gz"

cd /opt
if ! wget "$url" &>/dev/null; then
    echo "Failed to download Tomcat archive. Please check the Tomcat version and your network connection." >&2
    exit 1
fi

if ! tar -xvzf "apache-tomcat-${req_tom_ver}.tar.gz" &>/dev/null; then
    echo "Failed to extract Tomcat archive." >&2
    exit 1
fi

mv "apache-tomcat-${req_tom_ver}" "tomcat${tom_m_ver}"
rm -rf "apache-tomcat-${req_tom_ver}.tar.gz"

# Step 5: Configuring Tomcat
if ! ln -s "/opt/tomcat${tom_m_ver}/bin/startup.sh" "/usr/local/bin/tomcatup"; then
    echo "Failed to create symbolic link for startup.sh." >&2
    exit 1
fi

if ! ln -s "/opt/tomcat${tom_m_ver}/bin/shutdown.sh" "/usr/local/bin/tomcatdown"; then
    echo "Failed to create symbolic link for shutdown.sh." >&2
    exit 1
fi

if ! sed -i "s/8080/$port_number/" "/opt/tomcat${tom_m_ver}/conf/server.xml"; then
    echo "Failed to update server.xml." >&2
    exit 1
fi

if ! sed -i '21s/^/<!-- /' "/opt/tomcat${tom_m_ver}/webapps/host-manager/META-INF/context.xml"; then
    echo "Failed to update host-manager context.xml." >&2
    exit 1
fi

if ! sed -i '22s/$/ -->/' "/opt/tomcat${tom_m_ver}/webapps/host-manager/META-INF/context.xml"; then
    echo "Failed to update host-manager context.xml." >&2
    exit 1
fi

if ! sed -i '21s/^/<!-- /' "/opt/tomcat${tom_m_ver}/webapps/manager/META-INF/context.xml"; then
    echo "Failed to update manager context.xml." >&2
    exit 1
fi

if ! sed -i '22s/$/ -->/' "/opt/tomcat${tom_m_ver}/webapps/manager/META-INF/context.xml"; then
    echo "Failed to update manager context.xml." >&2
    exit 1
fi

line_number=57
file_path="/opt/tomcat${tom_m_ver}/conf/tomcat-users.xml"
user_info="<role rolename=\"admin-gui,manager-gui,manager,admin\"/>
<user username=\"admin\" password=\"tomcat\" roles=\"manager-gui,admin-gui,manager,admin\"/>"

if ! sed -i "${line_number}a\\$user_info" "$file_path"; then
    echo "Failed to update tomcat-users.xml." >&2
    exit 1
fi

# Step 6: Restarting Tomcat
tomcatdown &>/dev/null
tomcatup &>/dev/null

# Get host IP
host_ip=$(hostname -I | awk '{print $1}')

# Print completion message
echo "Tomcat server configuration completed."
echo "Access Tomcat server using the following URL:"
echo "http://${host_ip}:${port_number}"