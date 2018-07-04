# init nginx server for the cloud
yum install -y nginx
# apt-get install -y nginx
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/xizhendu/pub/master/init/init_01_nginx.conf

