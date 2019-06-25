service ssh restart
yes y | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && 
chmod og-wx ~/.ssh/authorized_keys
