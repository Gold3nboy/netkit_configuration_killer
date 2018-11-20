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

skeleton_folder_interface=\
"auto eth0 \n\
iface eth0 inet static \n\
\taddress \n\
\tnetmask \n\
\t#gateway "

skeleton_startup_restart="/etc/init.d/networking restart"




for (( i = 1; i <= $2; i++ )); do
    # folders
    name=$(echo $1$i)
    mkdir $name
    mkdir -p $name/etc/network
    touch $name/etc/network/interfaces
    echo -e $skeleton_folder_interface > $name/etc/network/interfaces



    #-startupfile
    echo $skeleton_startup_restart > $( echo $name".startup" )


    #if we are creating a router
    skeleton_startup_quagga="/etc/init.d/quagga restart"
    
    skeleton_router_daemons=\
"zebra=yes\n\
bgpd=no\n\
ospfd=yes\n\
ospf6d=no\n\
ripd=no\n\
ripngd=no\n\
isisd=no\n\
ldpd=no"

    if [[ $3 == 1 ]]; then
        echo $skeleton_startup_quagga >> $( echo $name".startup" )

        zebrafoldername=$name/etc/quagga
        mkdir -p $zebrafoldername
        echo -e $skeleton_router_daemons > $zebrafoldername/daemons
        
        
skeleton_router_zebraconf=\
"hostname $name\n\
password zebra\n\
enable password zebra\n\
\n\
interface eth0\n\
!ip address of this interface on this router\n\
ip address\n\
link-detect"

        echo -e $skeleton_router_zebraconf > $zebrafoldername/zebra.conf


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
        
        echo -e $skeleton_router_ospdfconf > $zebrafoldername/ospfd.conf

    fi
done
