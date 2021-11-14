#sed -i "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 rdblacklist=nouveau blacklist=nouveau\"/" /etc/default/grub
#grub2-mkconfig > /etc/grub2.cfg
#mkinitrd --force /boot/initramfs-`uname -r`.img `uname -r`
#echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf

#rmmod -v nouveau

yum -y install kernel-devel
yum -y groupinstall "Development Tools"

sh /opt/service/alces/files/nvidia.run -a -q -s

# Ensure /dev/nvidia* are created at boot
mkdir -p /var/lib/flight-setup/scripts/
echo "nvidia-smi" > /var/lib/flight-setup/scripts/02-nvidia.bash

# A100 GPU Fabric Manager
## Place the following file under `/opt/service/alces/files/` as `fabricmanager.tar.gz`
## wget -O /opt/service/alces/files/fabricmanager.tar.gz https://developer.download.nvidia.com/compute/cuda/redist/fabricmanager/linux-x86_64/fabricmanager-linux-x86_64-470.57.02.tar.gz 
#cd /tmp
#tar xf /opt/service/alces/files/fabricmanager.tar.gz
#cd fabricmanager
#./fm_run_package_installer.sh
#systemctl enable nvidia-fabricmanager
#systemctl start nvidia-fabricmanager

