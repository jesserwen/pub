
the_initial_server=$(w root -i | grep root | awk '{print $3}')

sed -i '/mirrors/d' /etc/hosts

echo "$the_initial_server   mirrors" >> /etc/hosts

mkdir -p /etc/yum.repos.d/tmp/
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/tmp/

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

yum install screen -y

mkdir -p /root/.ssh
wget -O /root/.ssh/authorized_keys http://mirrors/kickstart/id_rsa.pub

wget -O - http://mirrors/kickstart/init_client.bash | bash

