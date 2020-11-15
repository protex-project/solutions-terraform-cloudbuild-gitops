#!/bin/bash
apt update
apt -y install mc

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
