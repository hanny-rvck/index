#!/bin/bash
ip=$(ifconfig | grep "inet" | sed -n 1p | cut -d ' ' -f 10)
n=$(wc -l pcap$1.txt | cut -d ' ' -f 1)
i=1
j=0
while [ $i -le $n ]; do
l=$(cat pcap$1.txt | sed -n $i"p")
pr=$(echo $l | cut -d ' ' -f 6 | cut -d ":" -f 1)
if [[ "$pr" == "ICMP" ]]; then
dest=$(echo $l | cut -d ' ' -f 5 | cut -d "." -f -4)
if [[ "$dest" == "$ip" ]]; then
let j=$j+1
else
let j=$j+0
fi
let i=$i+1
else
let i=$i+1
fi
done
if [ $j -gt 20 ]; then
echo "**************** | WARNING | INTRUSION DETECTED | ICMP FLOOD ATTACK *****************"
echo "THE IP OF THE ATTACKER IS : " $ip
echo "-----------------------------------------------------"
echo "WARNING | INTRUSION DETECTED | ICMP FLOOD ATTACK" > IPSlog.log 
echo "THE IP OF THE ATTACKER IS : " $ip > IPSlog.log
echo "------------------------------------------------" > IPSlog.log
#iptables -A OUTPUT -p icmp --icmp-type echo-request -j DROP
else
echo " "
fi
