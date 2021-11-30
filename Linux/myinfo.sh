#!/bin/bash

# Check if script was run as root. Exit if True
if [ $UID -eq 0 ]
then
echo "Please Don't Run Under Sudo"
exit
fi

# Define Variables
outpath='~/research/sys_info.txt'
ip='$(hostname -I)'

# Check for research directory. Create if needed.
if [ -d ~/research ]
then
echo The ~/research Directory Already Exists!
else
mkdir ~/research
fi

# Check for output file. Remove if already exists.
if [ -f $outpath ]
then
rm $outpath
fi

# System Audit Script
echo "System Audit Script" > $outpath
date >> $outpath
echo "" >> $outpath
echo  "Machine Type Info:" >> $outpath
uname >> $outpath
$ip >> $outpath
hostname >> $outpath
echo "" >> $outpath
echo "DNS Servers:" >> $outpath
grep "nameserver" /etc/resolv.conf >> $outpath
echo "" >> $outpath
echo "Memory Info:" >> $outpath
free -h >> $outpath
echo "" >> $outpath
echo "CPU  Usage:" >> $outpath
lscpu >> $outpath
echo "" >> $outpath
echo "Disk Usage:" >> $outpath
df -H | head -2 >> $outpath
echo "" >> $outpath
echo "Users Logged In:" >> $outpath
users >> $outpath
echo "" >> $outpath
echo "777 Files:" >> $outpath
find /home -type f -perm 777 >> $outpath
echo "" >> $outpath
echo "Top 10 Processes:" >> $outpath
top -o %MEM | head -n 17 >> $outpath
