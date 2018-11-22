#! /bin/bash

# take 1 or more pc as input <name> <number>
# and set up ssh on them it will as for the ip and name
# of a pc to add in the hosts file
# EVERY FILE MUST ALREADY EXISTS

for (( i = 1; i <= $2; i++ )); do
	name=$(echo $1$i)
	echo "Ip for hosts file in $name "
	read ip </dev/tty
	echo "name of the target"
	read tname < /dev/tty
	ssh_startup_template="!you can add the ip-name of your ssh target in the host files\n\
!echo \"$ip	$tname\" > /etc/hosts\n\
!generate ssh key-pair\n\
echo -e '\\\n\\\n\\\n' | ssh-keygen\n\
pwd\n\
!some black magic down here\n\
cp /root/.ssh/id_rsa.pub /hostlab"
	echo -e $ssh_startup_template >> $name".startup"

done

