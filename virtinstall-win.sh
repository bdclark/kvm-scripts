#!/usr/bin/env bash
set -ex
### Simple virt-install script to install windows with virtio drivers ###
machine_name='windows-test'
ram='2048'
num_vcpus='1'
disk_size='20'
network='bridge=br0'
os_variant='win7'
install_iso='/var/lib/libvirt/images/Windows_Server_2012.ISO'
virtio_iso='/var/lib/libvirt/images/virtio-win-0.1-52.iso'

virt-install \
 --connect qemu:///system \
 --virt-type kvm \
 --name $machine_name \
 --ram $ram \
 --vcpus=$num_vcpus \
 --os-variant=$os_variant \
 --cdrom=$install_iso \
 --disk path=/var/lib/libvirt/images/$machine_name.img,size=$disk_size,format=raw,bus=virtio \
 --disk path=$virtio_iso,device=cdrom,perms=ro \
 --graphics vnc \
 --network $network \
 --noautoconsole

vnc_display=$(virsh vncdisplay $machine_name)
echo "vnc display $vnc_display)"
