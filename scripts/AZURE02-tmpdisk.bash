SWAPSIZEMB="4096" # We don't need more swap than this, probs broken if it hits this anyway

# Update waagent.conf to mount tmp disk as ext4 to /tmp
sed -i 's,ResourceDisk.Format=.*,ResourceDisk.Format=y,g' /etc/waagent.conf
sed -i 's,ResourceDisk.Filesystem=.*,ResourceDisk.Filesystem=ext4,g' /etc/waagent.conf
sed -i 's,ResourceDisk.MountPoint=.*,ResourceDisk.MountPoint=/tmp,g' /etc/waagent.conf
sed -i 's,ResourceDisk.EnableSwap=.*,ResourceDisk.EnableSwap=y,g' /etc/waagent.conf
sed -i "s,ResourceDisk.SwapSizeMB=.*,ResourceDisk.SwapSizeMB=$SWAPSIZEMB,g" /etc/waagent.conf

# Remove entry from fstab & unmount
sed -i '/^\/dev\/disk\/cloud\/azure_resource-part1.*/d' /etc/fstab
umount /dev/disk/cloud/azure_resource-part1

# Apply changes
systemctl restart waagent
chmod 1777 /tmp # Must be done after mount

cat << 'EOF' > /var/lib/flight-setup/scripts/01-tmpdisk.bash
MAX=12 # ~1 minute of waiting for mount
COUNT=1
while ! grep -q '^/dev/sdb1 /tmp ' /proc/mounts; do
    echo "Temp disk mount check loop #$COUNT"
    sleep 5
    if [ $COUNT -eq $MAX ] ; then 
        /opt/flight/opt/slurm/bin/scontrol update NodeName=$(hostname -s) State=DRAIN Reason="Check required"
        break
    fi 
    COUNT=$((COUNT + 1))
done
chmod 1777 /tmp
EOF
