# init nginx server for the cloud
yum install -y nginx
# apt-get install -y nginx

## Get the configured nginx conf file from external resource, we use github right now.
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/xizhendu/pub/master/init/nginx.conf


## Prepare the local http/kickstart directory, which will be accessed by clients.
mkdir -p /usr/share/nginx/html/kickstart
echo 'This is the default kickstart page of the cloud!' > /usr/share/nginx/html/kickstart/index.html
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjG3KUxtu6HWgB7rgoZWjXQqB2X+2C+Qe0Usbcf+i784rfYuXIu4L6MG2YlNDtUjylna0JNd1vAuwQXY1DXj4Xo0I/TgJcIvyXWFOTYcLX1PI/u0s4XMmu9btjrd+d5VbR/cahDz0KqxQN79vbLW863CNXFEb+EIKhy++hyb2BCHp1t14N1LSvOAad/NnGT+w7u92X+pO5TUtLrX/Y4rrS4OV0TKQE18eL4CdBA25OsA0suUvJBdgI+HGSw//fBh+2U1BJa0SvbFMnCDlo/H+s+gCc2460W8oN897TP/ZiyOmPJYgbynmrXYGoxCwuJFCmL2QaxNJWFrI68XwrnFjR xizhendu@keystone.predix.int.ge.com' > /usr/share/nginx/html/kickstart/id_rsa.pub

cat > /usr/share/nginx/html/kickstart/init_client.bash <<  "_the_real_eof_for_client"

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

_the_real_eof_for_client

