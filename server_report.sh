#!/bin/bash
# server_report.sh
# Server reconnaissance report
# Delivers important details about a server
# Warning: Run as sudo
# Version 0.0.3
# 2018-06-13

printf '%s\n' -----------------------------------------------------------------
echo Server Report $(hostname -f) $(date --utc +%FT%TZ)
printf '%s\n' -----------------------------------------------------------------

# Get hardware info
printf '%s\n' -----------------------------------------------------------------
echo System Info
printf '%s\n' -----------------------------------------------------------------
lsb_release -drc # OS info
printf '%s\n' -----------------------------------------------------------------
echo Additional System Info
printf '%s\n' -----------------------------------------------------------------
dmidecode -t system # System information
printf '%s\n' -----------------------------------------------------------------
echo BIOS Info
printf '%s\n' -----------------------------------------------------------------
dmidecode -t bios # BIOS information
printf '%s\n' -----------------------------------------------------------------
echo Hardware Info
printf '%s\n' -----------------------------------------------------------------
lshw -short # Show hardware
printf '%s\n' -----------------------------------------------------------------
echo CPU Info
printf '%s\n' -----------------------------------------------------------------
lscpu # CPU info
printf '%s\n' -----------------------------------------------------------------
echo Memory
printf '%s\n' -----------------------------------------------------------------
free -h # Memory info
printf '%s\n' -----------------------------------------------------------------
echo Storage Device Info
printf '%s\n' -----------------------------------------------------------------
lsblk -a # Storage device info
printf '%s\n' -----------------------------------------------------------------
echo Partitions Info
printf '%s\n' -----------------------------------------------------------------
fdisk -l # Partition info

# Get network info
printf '%s\n' -----------------------------------------------------------------
echo Network Interface Info
printf '%s\n' -----------------------------------------------------------------
ifconfig -a # Network interface info
printf '%s\n' -----------------------------------------------------------------
echo Hostfile Info
printf '%s\n' -----------------------------------------------------------------
cat /etc/hosts # Hostfile info
printf '%s\n' -----------------------------------------------------------------
echo DNS Info
printf '%s\n' -----------------------------------------------------------------
cat /etc/resolv.conf # DNS info
printf '%s\n' -----------------------------------------------------------------
echo Network Configuration Info
printf '%s\n' -----------------------------------------------------------------
cat /etc/sysconfig/network # Network configuration info

# List users
printf '%s\n' -----------------------------------------------------------------
echo Users
printf '%s\n' -----------------------------------------------------------------
cat /etc/passwd

# App layer information
printf '%s\n' -----------------------------------------------------------------
echo Installed Services Info
printf '%s\n' -----------------------------------------------------------------
chkconfig --list # Installed services
printf '%s\n' -----------------------------------------------------------------
echo Service Status Information
printf '%s\n' -----------------------------------------------------------------
service --status-all # Current service status
printf '%s\n' -----------------------------------------------------------------
echo Open Ports Info
printf '%s\n' -----------------------------------------------------------------
netstat -tulpn # Services and open ports
printf '%s\n' -----------------------------------------------------------------
echo Cron Job Info
printf '%s\n' -----------------------------------------------------------------
crontab -l # Scheduled jobs

# Web layer information
if [ -d "/var/www/html" ];
then
  printf '%s\n' -----------------------------------------------------------------
  echo Web Page Info
  printf '%s\n' -----------------------------------------------------------------
  tree /var/www/html # Installed services
fi

cert_check=$(ls -al /etc/ssl/certs/ | grep -e ".*\.pem\|.*\.crt\|.*\.cer\|.*\.j ks" | wc -l);
if [ "$cert_check" -ne 0 ];
then
  printf '%s\n' -----------------------------------------------------------------
  echo Certificate Info
  printf '%s\n' -----------------------------------------------------------------
  ls -al /etc/ssl/certs/ | grep -e ".*\.pem\|.*\.crt\|.*\.cer\|.*\.j ks" # Certificates
fi

apache_cert_check=$(grep -e "SSLCertificateFile|SSLCertificateKeyFile|SSLCACertficiate File" /etc/httpd/conf/httpd.conf | wc -l)
if [ "$apache_cert_check" -ne 0 ];
then
  printf '%s\n' -----------------------------------------------------------------
  echo Apache Certificate Info
  printf '%s\n' -----------------------------------------------------------------
  grep -e "SSLCertificateFile|SSLCertificateKeyFile|SSLCACertficiate File" /etc/httpd/conf/httpd.conf # Apache Certificates
fi

apache_virtual_host_check=$(grep -e "^\<VirtualHost" /etc/httpd/conf/httpd.conf | wc -l)
if [ "$apache_virtual_host_check" -ne 0 ];
then
  printf '%s\n' -----------------------------------------------------------------
  echo Apache Virtual Host Info
  printf '%s\n' -----------------------------------------------------------------
  grep -e "^\<VirtualHost" /etc/httpd/conf/httpd.conf # Apache Virtual Hosts
fi

mysql_check=$(pgrep mysql | wc -l);
if [ "$mysql_check" -ne 1 ];
then
  printf '%s\n' -----------------------------------------------------------------
  echo Database Info
  printf '%s\n' -----------------------------------------------------------------
  mysql -V # MySQL version info
fi
