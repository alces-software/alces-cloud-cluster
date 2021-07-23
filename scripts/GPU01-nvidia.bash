#sed -i "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 rdblacklist=nouveau blacklist=nouveau\"/" /etc/default/grub
#grub2-mkconfig > /etc/grub2.cfg
#mkinitrd --force /boot/initramfs-`uname -r`.img `uname -r`
#echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf

#rmmod -v nouveau

yum -y install kernel-devel
yum -y groupinstall "Development Tools"

sh /opt/service/alces/files/nvidia.run -a -q -s
