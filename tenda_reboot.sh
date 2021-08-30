#!/bin/bash

host="192.168.88.1" // Tenda F6 IP
passwd="123456" // Tenda password
passwdb64=`echo -n $passwd | base64`

#if [ `ping -c5 8.8.8.8 | grep "100% packet loss" | wc -l` -eq 1 ]; then

  echo `date` - No ping, Tenda RESTARTING >>/var/tenda-reboot.log

  #Tenda login
  curl -v -H "Host: $host" -H "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0" \
  -H "Accept: */*" -H "Accept-Language: en-US,en;q=0.5" -H "Accept-Encoding: gzip, deflate" -H "Connection: keep-alive" \
  -H "Cookie: bLanguage=en; ecos_pw=${passwdb64}cvd:language=cn" \
  -d "password=$passwdb64" -X POST \
  "http://$host/login/Auth"

  #Tenda reboot
  curl -v --cookie "bLanguage=en; ecos_pw=${passwdb64}cvd:language=cn" --referer "http://$host/index.html" \
  "http://$host/goform/sysReboot?module1=sysOperate&action=reboot"


#fi
