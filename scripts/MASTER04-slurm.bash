#!/bin/bash
# Check if Slurm is already installed

if [ -d /opt/flight/opt/slurm ] ; then
   echo "Slurm directory already exists - remove /opt/flight/opt/slurm and re-run"
   exit 1
fi

yum -y install munge munge-devel munge-libs perl-Switch
yum -y install flight-slurm flight-slurm-contribs flight-slurm-devel flight-slurm-example-configs flight-slurm-libpmi flight-slurm-perlapi flight-slurm-pam_slurm flight-slurm-slurmctld flight-slurm-slurmd flight-slurm-slurmdbd
yum -y install mariadb mariadb-embedded mariadb-test

systemctl enable mariadb
systemctl start mariadb
mysql -uroot -e "create user 'slurm'@'localhost' identified by '';"
mysql -uroot -e "grant all on slurm_acct_db.* TO 'slurm'@'localhost';"
mysql -uroot -e "CREATE DATABASE slurm_acct_db;"

curl http://10.110.1.200/deployment/files/munge.key > /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
chown munge /etc/munge/munge.key

systemctl enable munge
systemctl start munge

mkdir -p /opt/flight/opt/slurm/var/log
chown nobody /opt/flight/opt/slurm/var/log/
mkdir -p /opt/flight/opt/slurm/var/spool/slurm.state
chown nobody /opt/flight/opt/slurm/var/spool/slurm.state
mkdir -p /opt/flight/opt/slurm/var/run
chown nobody /opt/flight/opt/slurm/var/run

curl http://10.110.1.200/deployment/files/slurm.conf > /opt/flight/opt/slurm/etc/slurm.conf
curl http://10.110.1.200/deployment/files/slurmdbd.conf > /opt/flight/opt/slurm/etc/slurmdbd.conf
curl http://10.110.1.200/deployment/files/gres.conf > /opt/flight/opt/slurm/etc/gres.conf

chmod 600 /opt/flight/opt/slurm/etc/slurmdbd.conf
chown nobody /opt/flight/opt/slurm/etc/slurmdbd.conf

systemctl enable flight-slurmdbd
systemctl start flight-slurmdbd

systemctl enable flight-slurmctld
systemctl restart flight-slurmctld
