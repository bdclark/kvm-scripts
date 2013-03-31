#!/usr/bin/env bash
### Simple virt-install script ###

set -e

machine_name='my-vm'
ram='2048'
num_vcpus='1'
disk_size='20'
disk_format='raw'
network='bridge=br0'
disk_bus='virtio'
net_model='virtio'
os_variant='ubuntuprecise'

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
 --disk path=/var/lib/libvirt/images/$machine_name.img,size=$disk_size,format=$disk_format,bus=$disk_bus \
 --graphics vnc \
 --network $network,model=$net_model \
 --noautoconsole \
 --$boot_type

vnc_display=$(virsh vncdisplay $machine_name)
echo "vnc display $vnc_display)"
