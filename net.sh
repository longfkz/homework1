#!/bin/sh
proc="firefox"
length=5
while getopts l:s:p: flag
do
case "${flag}" in
l) length=${OPTARG};;
p) proc=${OPTARG};;
esac
done
echo "length: $length";
echo "proc:$proc";
sudo netstat -tunapl |
awk '/'"${proc}"'/ {print $5}'|
cut -d: -f1 |
sort |
uniq -c |
sort |
tail -n $length |
grep -oP '(\d+\.){3}\d+' |
while read IP ; do whois $IP |
awk -F':' '/^Organization/ {print $2}' ;
done
