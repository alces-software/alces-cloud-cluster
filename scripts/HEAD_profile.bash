curl http://10.110.1.200/deployment/scripts/ALL01-site.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/MASTER00-flight-setup.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/AZURE01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/ALL02-pdsh.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/MASTER01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/MASTER02-nfs.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/MASTER04-slurm.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/MASTER05-flight.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/HPC01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/HPC02-pkgs.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE90-ipa.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/ALL03-fcops.bash |/bin/bash -x | tee -a /tmp/mainscript-default-output
