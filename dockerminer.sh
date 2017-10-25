#!/bin/bash
coinhivefile="coin-hive.js"

clear

sitekey=$(whiptail --title "SiteKey" --inputbox "Your public site key" 10 60 3>&1 1>&2 2>&3)
username=$(whiptail --title "Username" --inputbox "Please set an username" 10 60 3>&1 1>&2 2>&3)
threads=$(whiptail --title "Threads" --inputbox "Set a number of proc threads" 10 60 3>&1 1>&2 2>&3)

sed -i "s|{SITEKEY}|$sitekey|g" $coinhivefile
sed -i "s|{USERNAME}|$username|g" $coinhivefile
sed -i "s|{THREADS}|$threads|g" $coinhivefile

docker build -t dockerminer .

dockername=$(whiptail --title "Docker name" --inputbox "Choose a name for your Docker" 10 60 3>&1 1>&2 2>&3)
if (whiptail --title "CPU Limit" --yesno "Do you want to limit processor for your Docker ?" 10 60) then
        cpuluimit=$(whiptail --title "CPU Limit" --inputbox "Choose a value between 0.1 and 8" 2 10 60 3>&1 1>&2 2>&3)
        docker run -d --name $dockername --cpus="$cpulimit" dockerminer
else
        docker run -d --name $dockername dockerminer
fi
