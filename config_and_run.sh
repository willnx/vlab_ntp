#!/bin/sh
#
# Dynamically update an NTP source upon service startup

# Exit the moment any single command fails
set -e

update_ntp_servers() {
  if [ ! -z ${VLAB_NTP_SERVER+x} ]; then
    echo "Using NTP server" ${VLAB_NTP_SERVER}
    sed -i -e "s/0.us.pool.ntp.org/${VLAB_NTP_SERVER}/g" /etc/chrony/chrony.conf
  else
    echo "Using default NTP server sources"
  fi
}

run_chrony() {
  # Run chronyd and attach all logging to stdout/stderr
  /usr/sbin/chronyd -d
}

main() {
  update_ntp_servers
  run_chrony
}
main
