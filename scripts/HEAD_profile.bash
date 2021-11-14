curl http://10.110.1.200/deployment/scripts/base/BASE_HEAD_profile.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/azure/PLATFORM_HEAD_profile.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
curl http://10.110.1.200/deployment/scripts/alces/STACK_HEAD_profile.bash | /bin/bash -x | tee -a /tmp/mainscript-default-output
