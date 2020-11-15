#!/bin/bash
apt update
apt -y install mc

mkdir /usr/local/eosio
mkdir /usr/local/eosio/bin
mkdir /usr/local/eosio/etc

cd /root
cp eosio/bin/cleos /usr/local/eosio/bin
cp eosio/bin/nodeos /usr/local/eosio/bin
cp eosio/etc/config.ini /usr/local/eosio/etc

cp backup.sh /root
cp start_nodeos.sh /root


