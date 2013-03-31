#!/usr/bin/env bash
set -e
### Simple script to import a virtual machine with an existing image ###

machine_name='winsrvr-2012-golden'
disk_path='/var/lib/libvirt/images/winsrvr-2012-golden.img'
ram='2048'
num_vcpus='1'
disk_size='20'
network='bridge=br0'
os_variant='win7'

virt-install \
 --connect qemu:///system \
 --virt-type kvm \
 --name $machine_name \
 --ram $ram \
 --vcpus=$num_vcpus \
 --os-variant=$os_variant \
 --disk path=$disk_path,size=$disk_size,format=raw,bus=virtio \
 --graphics vnc \
 --network $network,model=virtio \
 --noautoconsole \
 --import

vnc_display=$(virsh vncdisplay $machine_name)
echo "vnc display $vnc_display)"
