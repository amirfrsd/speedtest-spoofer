#!/usr/bin/env bash
echo 'SpeedTest.Net Test Spoofer Initialized'
echo ' '
sleep 1
echo 'This Tool is made by Amir Hossein Farsad https://github.com/amirfrsd'
echo 'and is modified by Mahmoud Sagharjoughi <mahmood.sa225@gmail.com>'
sleep 1
echo '========================================'
echo '=============Test Spoofer==============='
echo ' '
sleep 1

echo 'Enter Your wanted Download Speed (example : 12227 for 12mbps):'
read downloadSpeed
echo 'Well, Now enter your wanted Upload Speed (example : 24228 for 24mbps):'
read uploadSpeed
echo 'Hmmm, What about your wanted ping? enter it (example : 45):'
read ping
echo 'Okay, type in the server name you want to spoof test on it (find it on the internet):'
read testServer

if [ "$(uname)" == "Darwin" ]; then
    md5String=`md5 -s $ping-$uploadSpeed-$downloadSpeed-297aae72 | sed 's/.* //'` 
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    md5String=$(echo -n $ping'-'$uploadSpeed'-'$downloadSpeed'-297aae72' | md5sum | awk '{print $1}' | sed 's/.* //')
fi

if [ -z "$downloadSpeed" ] || [ -z "$uploadSpeed" ] || [ -z "$ping" ]
then
  echo check your inputs
  exit 1
fi
if [ -z "$testServer" ]
then
  echo check your inputs, test servers can be found at : http://speedtest.net/speedtest-servers.php
  exit 1
fi
echo Wait For My Magic Bro
output=`curl -sS -X "POST" "http://www.speedtest.net/api/api.php" \
     -H "Origin: http://c.speedtest.net" \
     -H "Cookie: place" \
     -H "Connection: close" \
     -H "Referer: http://c.speedtest.net/flash/speedtest.swf" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -H "Host: www.speedtest.net" \
     -H "User-Agent: DrWhat Speedtest" \
     --data-urlencode "upload=$uploadSpeed" \
     --data-urlencode "recommendedserverid=$testServer" \
     --data-urlencode "ping=$ping" \
     --data-urlencode "hash=$md5String" \
     --data-urlencode "download=$downloadSpeed" \
     --data-urlencode "serverid=$testServer" \
     --data-urlencode "startmode=recommendedselect" \
     --data-urlencode "promo=" \
     --data-urlencode "accuracy=8" | cut -f1 -d"&" | sed -e 's#.*=\(\)#\1#'`
echo Your Fake result is Baked bro
echo ''
urlString="http://speedtest.net/my-result/$output"
echo Result Link: $urlString
echo Opening ...
sleep 3
xdg-open $urlString
