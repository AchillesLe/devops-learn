# genkey
ssh-keygen -t rsa -b 4096 -C "dev01"

# login to server

# create user
sudo useradd dev01
# not set pw

# swicth to dev01
sudo su - dev01
pwd
id

# create folder
mkdir .ssh
chmod 700 .ssh

# create auth key
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

vim .ssh/authorized_keys



# create 