#!/bin/bash
apt update
apt install qemu
snap install novnc
qemu-img create -f raw win7.img 10G
git clone https://github.com/Juvenal-Yescas/mediafire-dl
cd mediafire-dl
pip3 install -r requirements.txt
python3 mediafire-dl.py http://www.mediafire.com/file/sj7694734mb06jv/downloadisofile.blogspot.com_Tiny7.iso/file
cd ..
novnc --listen 80 &
qemu-system-x86_64 -hda ./win7.img -m 3072 \
-net nic,model=virtio -net user -cdrom ./mediafire-dl/downloadisofile.blogspot.com_Tiny7.iso \
-rtc base=localtime,clock=host -smp cores=4,threads=4 \
-usbdevice tablet -vga vmware
