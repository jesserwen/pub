

# What the client needs to do is only to find out the ipaddress of the initial server
# Everything else will be excuted within the script, hosted on the intital server.
# Steps and executions need to be included in server side: ${www_root}/kickstart/init_client.bash

# Copy/Paste the following 2 line is enough by design:
the_initial_server=$(w root -i | grep root | awk '{print $3}')
wget -O - http://${the_initial_server}/kickstart/init_client.bash | bash

# Good Luck!
# Author: Xizhen Du<xizhen.du@ge.com>

