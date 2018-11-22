#! /bin/bash

# numero di argomenti : 
#                       1-stringa
#                       2-numero di fine
#                       3-bitmask = router=1 / pc=0

# estendibile con -q

# output: -numero di fine- cartelle con nome : STRINGA + NUMERO
#         -numero di fine- startup file con nome: STRINGA + NUMERO + .startup
#         -dentro ogni cartella etc/network/interfaces con skeleton di script
#         -dentro ogni startup file base config per init.d

#MAYBE NOT NEEDED- FOR DNS EVERYTHING CHANGES
#if [[ $2 == 1 ]]; then
#    #statements
#fi

#common values to all 
if [[ $1!='r' ]]; then
    exit
fi
for (( i = 1; i <= $2; i++ )); do
    # folders
    name=$(echo $1$i)

        zebrafoldername=$name/etc/quagga

        skeleton_router_ospfdconf=\
"hostname $name\n\
password zebra\n\
\n\
interface eth0\n\
ospf hello-interval 2\n\
!if forced weight,use this changing x\n\
!ospf cost x\n\
\n\
!this command activates ospf on the next subsets\n\
router ospf\n\
network   area\n\
network   area\n\
network   area"
        
        echo -e $skeleton_router_ospfdconf > $zebrafoldername/ospfd.conf

done
