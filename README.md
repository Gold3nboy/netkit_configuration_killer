# Netkit configuration killers
## creator.sh : usage
./creator.sh <device name> <highest number of devices> <router = 1 | pc = 0>
### example 
./creator.sh r 12 1
### output of example
* folders from r1 to r12 
* scripts from r1.startup to r12.startup
* startup scripts contain /etc/init.d restart command 
* in each folder, /etc/network/interfaces skeleton inserted (to be completed manually)
* in each folder, /etc/quagga/ contains daemons , zebra.conf and ospfd.conf skeletons (to be completed manually)

