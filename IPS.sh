#!/bin/bash

while true; do
echo "Analysing network traffic ..."
n=$(ls /root/Desktop/SECRES/PCAP/ | wc -l)
timeout 1 tcpdump -i eth2 -w /root/Desktop/SECRES/PCAP/pcap$n.pcap
tcpdump -r /root/Desktop/SECRES/PCAP/pcap$n.pcap > /root/Desktop/SECRES/TXT/pcap$n.txt 

./SYN.sh $n 2 &

./ICMP.sh $n 2 &

./UDP.sh $n &

echo " " 
echo "---------------------------------------------------------"
done


