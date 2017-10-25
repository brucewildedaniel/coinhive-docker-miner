#!/bin/bash
coinhivefile="coin-hive.js"

clear

sitekey=$(whiptail --title "SiteKey" --inputbox "Your CoinHive public site key" 10 60 3>&1 1>&2 2>&3)
username=$(whiptail --title "Username" --inputbox "Please set an CoinHive username" 10 60 3>&1 1>&2 2>&3)
threads=$(whiptail --title "Threads" --inputbox "Set a number of threads" 10 60 3>&1 1>&2 2>&3)

sed -i "s|{SITEKEY}|$sitekey|g" $coinhivefile
sed -i "s|{USERNAME}|$username|g" $coinhivefile
sed -i "s|{THREADS}|$threads|g" $coinhivefile

docker build -t dockerminer .

dockername=$(whiptail --title "Docker name" --inputbox "Choose a name for your Docker" 10 60 3>&1 1>&2 2>&3)
if (whiptail --title "CPU Limit" --yesno "Do you want to limit processors for your Docker ?" 10 60) then
        cpulimit=$(whiptail --title "CPU Limit" --inputbox "Choose a value between 1 and 8" 10 60 2 3>&1 1>&2 2>&3)
        docker run -d --name $dockername --cpus="$cpulimit" dockerminer
else
        docker run -d --name $dockername dockerminer
fi
