#!/bin/sh
#
# Dynamically update an NTP source upon service startup

# Exit the moment any single command fails
set -e

update_ntp_server() {
  if [ ! -z ${VLAB_NTP_SERVER+x} ]; then
    echo "Using NTP server" ${VLAB_NTP_SERVER}
    sed -i -e "s/0.us.pool.ntp.org/${VLAB_NTP_SERVER}/g" /etc/chrony/chrony.conf
  else
    echo "Using default NTP server sources"
  fi
}

update_ntp_client_network() {
  if [ ! -z ${VLAB_NTP_CLIENT_NETWORK+x} ]; then
    echo "Allowing NTP clients on network" ${VLAB_NTP_CLIENT_NETWORK}
    local netwk=$(echo ${VLAB_NTP_CLIENT_NETWORK} | sed 's/\//\\\//g')
    sed -i -e "s/allow 192.168.1.0\/24/allow ${netwk}/g" /etc/chrony/chrony.conf
  else
    echo "Allowing default network access to NTP client"
  fi
}

update_timezone() {
  if [ ! -z ${VLAB_TIMEZONE+x} ]; then
    echo "Using timezone" ${VLAB_TIMEZONE}
    if [ ! -e /usr/share/zoneinfo/${VLAB_TIMEZONE} ]; then
      echo "Invalid timezone supplied."
      exit 1
    else
      cp /usr/share/zoneinfo/${VLAB_TIMEZONE} /etc/localtime
    fi
  else
    echo "Using timezone UTC-0"
  fi
}

run_chrony() {
  # Run chronyd and attach all logging to stdout/stderr
  /usr/sbin/chronyd -d
}

main() {
  update_ntp_server
  update_ntp_client_network
  update_timezone
  run_chrony
}
main
