#!/bin/bash
if [ $2 -eq 1 ]; then
rm data.csv data2.csv stat.txt
touch data.csv
touch data2.csv
touch stat.txt
fi
ip=$(ifconfig | grep 'inet' | sed -n 1p | cut -d ' ' -f 10)
n=$(wc -l pcap$1.txt | cut -d ' ' -f 1)
i=1
while [ $i -le $n ]; do
kk=$(cat pcap$1.txt | sed -n $i'p')  #select ligne i
k=$(echo $kk | cut -d ' ' -f 5 | cut -d "." -f -4) #ip dest
if [ "$k" == "$ip" ]; then
if [[ $kk =~ "S." ]]; then
o=$(echo $kk | cut -d ' ' -f 3 | sed 's/\./ /g' | wc -w)
h=$o
let h=$h-1
p=$(echo $kk | cut -d ' ' -f 3 | cut -d ":" -f 1 | cut -d '.' -f -$h)
echo $p >> data2.csv
r=$(grep $p data.csv)
if [ "$r" == '' ];then
echo $p >> data.csv
fi
let i=$i+1
else
let i=$i+1
fi
else
let i=$i+1
fi
done
cat data.csv | while read ligne; do
g=$(grep -c $ligne data2.csv)
echo $ligne":"$g >> stat.txt
done
n=$(wc -l stat.txt | cut -d ' ' -f 1)
i=1
while [ $i -le $n ]; do
l=$(cat stat.txt | sed -n $i'p')
num=$(echo $l | cut -d ":" -f 2)
echo $num
if [ "$num" -gt "10" ]; then
ns=$(echo $l | cut -d ":" -f 1)
ip=$(nslookup $ns | grep "Address: " | cut -d " " -f 2)
echo "**************** | WARNING | INTRUSION DETECTED | SYN FLOOD ATTACK *****************"
echo "THE IP OF THE ATTACKER IS : " $ip
echo "-----------------------------------------------------"
echo "WARNING | INTRUSION DETECTED | SYN FLOOD ATTACK" > IPSlog.log 
echo "THE IP OF THE ATTACKER IS : " $ip > IPSlog.log
echo "------------------------------------------------" > IPSlog.log
else
echo "  "
fi
let i=$i+1
done
