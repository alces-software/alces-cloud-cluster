yum -y install flight-runway flight-starter flight-env flight-desktop vte-profile vte 

yum -y swap flight-starter-banner flight-direct-flight-starter-banner

/opt/flight/bin/flight config set cluster.name clustername-cloud1

ENVDIR=`rpm -ql flight-env |grep 'bin/flenv' |sed 's,/bin/flenv,,g'`

cat << EOF > $ENVDIR/etc/config.yml
# Paths to available types for desktop & env
type_paths:
  - /opt/flight/usr/lib/env/types
  - /opt/flight/etc/env/types
# Path to global/system-wide depots
global_depot_path: /opt/apps/flight/env
# Path to global/system-wide cache
global_cache_path: /opt/apps/flight/env/cache
# Path to global/system-wide build cache
global_build_cache_path: /opt/apps/flight/env/cache/build
EOF

echo "user.max_user_namespaces=100" > /etc/sysctl.d/50-flight.conf

HOME=/root

#mv /etc/profile.d/flightcenter.sh /etc/profile.d/flightcenter.sh.old
/opt/flight/bin/flight set always on

# Set Flight always on globally
cat << EOF > /etc/xdg/flight/settings.rc
################################################################################
##
## Alces Flight - Shell configuration file
## Copyright (c) 2019 Alces Flight Ltd
##
################################################################################
flight_STARTER_always=enabled
EOF
