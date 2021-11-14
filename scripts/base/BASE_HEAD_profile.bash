curl http://10.110.1.200/deployment/scripts/base/ALL01-site.bash | /bin/bash -x | tee -a /tmp/mainscript-base-default-output
curl http://10.110.1.200/deployment/scripts/base/ALL02-pdsh.bash | /bin/bash -x | tee -a /tmp/mainscript-base-default-output
curl http://10.110.1.200/deployment/scripts/base/HPC01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-base-default-output
curl http://10.110.1.200/deployment/scripts/base/HPC02-pkgs.bash | /bin/bash -x | tee -a /tmp/mainscript-base-default-output
curl http://10.110.1.200/deployment/scripts/base/MASTER01-base.bash | /bin/bash -x | tee -a /tmp/mainscript-base-default-output
