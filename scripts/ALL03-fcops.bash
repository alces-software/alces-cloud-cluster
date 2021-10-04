# Requires on-site VPN to be setup
curl http://10.110.1.202/resources/salt/salt_minion.sh | bash

cat << EOF > /var/lib/flight-setup/scripts/03-fcops.bash
MAX=24 # ~2 minute of waiting for mount
COUNT=1
while [ ! -f /tmp/fcops_adopted ] ; do
    echo "FCOPs salt completion check loop #$COUNT"
    sleep 5
    if [ $COUNT -eq $MAX ] ; then
        /opt/flight/opt/slurm/bin/scontrol update NodeName=$(hostname -s) State=DRAIN Reason="Ops configuration not complete"
        break
    fi
    COUNT=$((COUNT + 1))
done
EOF
