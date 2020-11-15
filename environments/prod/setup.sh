#!/bin/bash
apt update
apt -y install mc screen libbz2-dev libstdc++6 libssl-dev libgmp3-dev build-essential libicu-dev zlib1g-dev libtinfo5 libusb-1.0-0 libfcgi-dev libcurl3-gnutls libcurl3

mkdir /usr/local/eosio
mkdir /usr/local/eosio/bin
mkdir /usr/local/eosio/etc

cd /root
git clone https://github.com/protex-project/solutions-terraform-cloudbuild-gitops.git
cp solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/cleos /usr/local/eosio/bin
cp solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/nodeos /usr/local/eosio/bin
cp solutions-terraform-cloudbuild-gitops/environments/prod/eosio/etc/config.ini /usr/local/eosio/etc

cp solutions-terraform-cloudbuild-gitops/environments/prod/eosio/backup.sh /root
cp solutions-terraform-cloudbuild-gitops/environments/prod/eosio/start_nodeos.sh /root

rm -rf solutions-terraform-cloudbuild-gitops
