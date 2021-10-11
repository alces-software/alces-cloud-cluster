#!/bin/bash

CLUSTERNAME="" # lower-case
IMAGE_PATH=""
SSH_PUB_KEY=""
IPAPASS=""

echo "WARNING: This script will modify many files in the repository. DO NOT RUN IF VARIABLES IN THIS SCRIPT HAVE NOT BEEN SETUP"
echo
read -p "Proceed with file setup? [y/N] " answer

case $answer in
    y|Y)
        echo "Setting up files..."
        ;;
    *)
        echo "Exiting..."
        exit 0
        ;;
esac

cd /opt/flight/deployment

for file in $(grep -Ril clustername files scripts templates tools) ; do
    sed -i "s/clustername/$CLUSTERNAME/g" $file
    sed -i "s/CLUSTERNAME/${CLUSTERNAME^^}/g" $file
done

for file in $(grep -Ril IMAGE_PATH templates) ; do
    sed -i "s,IMAGE_PATH,$IMAGE_PATH,g" $file
done

for file in $(grep -Rl 'ssh-rsa REPLACEME' files scripts templates tools) ; do
    sed -i "s,ssh-rsa REPLACEME,$SSH_PUB_KEY,g" $file
done

for file in $(grep -Rl 'IPAPASS' scripts) ; do
    sed -i "s/IPAPASS/$IPAPASS/g" $file
done

tr -dc A-Za-z0-9 </dev/urandom | head -c 256 ; echo '' > files/munge.key

cd -
echo "Done."
echo
cat << EOF
You will still need to
- Clone repos (see support/repoclone.sh for help doing so)
- Setup files/slurm.conf and files/gres.conf
- Verify scripts/*_profile.bash contain the various scripts wanted for the build
EOF
