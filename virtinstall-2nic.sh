#!/usr/bin/env bash
### Simple virt-install script ###

set -e

machine_name='nagios'
ram='4096'
num_vcpus='4'
disk_size='50'
disk_format='qcow2'
disk_name=$machine_name.qcow2
network1='bridge=br-int'
network2='bridge=br-oob'
disk_bus='virtio'
net_model='virtio'
os_variant='ubuntuquantal'

#If using PXE, specifiy boot_type='pxe'
boot_type='pxe'
#If using ISO, specify boot_type='cdrom=<path_to_iso>'
#boot_type='cdrom=/var/lib/libvirt/images/raring-server-amd64.iso'

virt-install \
 --connect qemu:///system \
 --virt-type kvm \
 --name $machine_name \
 --ram $ram \
 --vcpus=$num_vcpus \
 --os-type=linux \
 --os-variant=$os_variant \
 --disk path=/var/lib/libvirt/images/$disk_name,size=$disk_size,format=$disk_format,bus=$disk_bus \
 --graphics vnc \
 --network $network1,model=$net_model \
 --network $network2,model=$net_model \
 --noautoconsole \
 --$boot_type

vnc_display=$(virsh vncdisplay $machine_name)
echo "vnc display $vnc_display)"
