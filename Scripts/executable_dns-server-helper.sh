#!/bin/sh

mode=$1
env=$2


if [[ "${env}" == "home" ]]; then
  hostIp=$DNS_HOME_IP
  toReplace=$DNS_SMINO_IP
fi
if [[ "${env}" == "jona" ]]; then
  hostIp=$DNS_SMINO_IP
  toReplace=$DNS_HOME_IP
fi

dnsServers=''

case $mode in
  host)
    dnsServers=$hostIp
    eval sed "s/HOST_IP=$toReplace/HOST_IP=$hostIp/"  "$HOME/git/smino/Source/.env" | grep HOST_IP
    ;;
  public)
    dnsServers=$DNS_PUBLIC_SERVERS
    echo "only dns server set"
    ;;
  both)
    dnsServers="$DNS_PUBLIC_SERVERS $hostIp"
    eval sed "s/HOST_IP=$toReplace/HOST_IP=$hostIp/"  "$HOME/git/smino/Source/.env" | grep HOST_IP
    ;;
  *)
    echo "no mode choosen host/public/both"
    exit 1
esac

command="networksetup -setdnsservers Wi-Fi $dnsServers"
echo $command
eval $command



