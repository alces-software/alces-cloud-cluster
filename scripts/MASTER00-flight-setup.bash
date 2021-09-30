#
# Run this before AZURE02-tmpdisk, GPU01-nvidia & ALL03-fcops
#


mkdir -p /var/lib/flight-setup/{bin,scripts}
mkdir -p /var/log/flight-setup

cat << 'EOF' > /var/lib/flight-setup/bin/flight-setup
function flightsetup {
    echo "-------------------------------------------------------------------------------"
    echo "Running Flight Setup - $(date)"
    echo "-------------------------------------------------------------------------------"
    for script in $(find /var/lib/flight-setup/scripts -type f -iname *.bash) ; do
        echo "Running $script..." >> /var/log/flight-setup/flight-setup.log
        /bin/bash $script >> /var/log/flight-setup/flight-setup.log
    done
    echo "-------------------------------------------------------------------------------"
    echo "Complete Flight Setup - $(date)"
    echo "-------------------------------------------------------------------------------"
}
trap flightsetup EXIT
EOF

cat << EOF > /etc/systemd/system/flight-setup.service
[Unit]
Description=Flight Setup service
After=network-online.target remote-fs.target
Before=flight-slurmctld.service
[Service]
ExecStart=/bin/bash /var/lib/flight-setup/bin/flight-setup
Type=oneshot
SysVStartPriority=99
TimeoutSec=0
RemainAfterExit=yes
Environment=HOME=/root
Environment=USER=root
[Install]
WantedBy=multi-user.target
EOF

chmod 664 /etc/systemd/system/flight-setup.service
systemctl daemon-reload
systemctl enable flight-setup.service
