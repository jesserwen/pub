
#!/bin/bash
# wget -O - https://raw.githubusercontent.com/xizhendu/pub/master/init_02_client.bash | bash nginx_ip_address

the_initial_server=$1

mkdir -p /etc/yum.repos.d/tmp/
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/tmp/

echo "$the_initial_server   mirrors" >> /etc/hosts

cat > /etc/yum.repos.d/std.repo << _eof_
[os]
name=os
baseurl=http://mirrors/centos/7/os/x86_64/
gpgcheck=0

[updates]
name=updates
baseurl=http://mirrors/centos/7/updates/x86_64/
gpgcheck=0

[extras]
name=extras
baseurl=http://mirrors/centos/7/extras/x86_64/
gpgcheck=0

[epel]
name=epel
baseurl=http://mirrors/epel/7/x86_64/
gpgcheck=0
_eof_


mkdir -p /root/.ssh
wget -O /root/.ssh/authorized_keys http://mirrors/kickstart/id_rsa.pub

