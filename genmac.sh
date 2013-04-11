#!/bin/bash
# generate a random mac address for the qemu nic
printf '52:54:00:%02X:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256))
