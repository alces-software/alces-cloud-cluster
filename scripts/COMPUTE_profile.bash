curl http://10.110.1.200/deployment/scripts/ALL01-site.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE00-flight-setup.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/AZURE01-base.bash  | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/AZURE02-tmpdisk.bash  | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/ALL02-pdsh.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE99-nfs.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/HPC01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/HPC02-pkgs.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE90-ipa.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE10-slurm.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/SLAVE11-flight.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/ALL03-fcops.bash |/bin/bash -x | tee -a /tmp/mainscript-default-output
