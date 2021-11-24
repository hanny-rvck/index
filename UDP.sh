#!/bin/bash
if [ $2 -eq 1 ]; then
rm udpdata.csv udpdata2.csv udpstat.txt
touch udpdata.csv
touch udpdata.csv
touch udpstat.txt
fi
ip=$(ifconfig | grep 'inet' | sed -n 1p | cut -d ' ' -f 10)
n=$(wc -l pcap$1.txt | cut -d ' ' -f 1)
i=1
while [ $i -le $n ]; do
kk=$(cat pcap$1.txt | sed -n $i'p')
k=$(echo $kk | cut -d ' ' -f 5 | cut -d "." -f -4)
if [ "$k" == "$ip" ]; then
if [[ $kk =~ "UDP" ]]; then
o=$(echo $kk | cut -d ' ' -f 3 | sed 's/\./ /g' | wc -w)
h=$o
let h=$h-1
p=$(echo $kk | cut -d ' ' -f 3 | cut -d ":" -f 1 | cut -d '.' -f -$h)
echo $p >> udpdata.csv
r=$(grep $p udpdata2.csv)
if [ "$r" == '' ];then
echo $p >> udpdata.csv
fi
let i=$i+1
else
let i=$i+1
fi
else
let i=$i+1
fi
done
cat udpdata.csv | while read ligne; do
g=$(grep -c $ligne udpdata2.csv)
echo $ligne":"$g >> udpstat.txt
done
n=$(wc -l udpstat.txt | cut -d ' ' -f 1)
i=1
while [ $i -le $n ]; do
l=$(cat udpstat.txt | sed -n $i'p')
num=$(echo $l | cut -d ":" -f 2)
echo $num
if [ "$num" -gt "80" ]; then
ns=$(echo $l | cut -d ":" -f 1)
ip=$(nslookup $ns | grep "Address: " | cut -d " " -f 2)
echo "**************** | WARNING | INTRUSION DETECTED | UDP FLOOD ATTACK *****************"
echo "THE IP OF THE ATTACKER IS : " $ip
iptables -A INPUT -s $ip -p tcp -m udp -j DROP
echo "-----------------------------------------------------"
echo "WARNING | INTRUSION DETECTED | UDP FLOOD ATTACK" > IPSlog.log 
echo "THE IP OF THE ATTACKER IS : " $ip > IPSlog.log
echo "------------------------------------------------" > IPSlog.log
else
echo "  "
fi
let i=$i+1
done
