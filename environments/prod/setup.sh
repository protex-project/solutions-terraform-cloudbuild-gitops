#!/bin/bash

#Установка зависимостей
apt update
apt -y install mc screen libbz2-dev libstdc++6 libssl-dev libgmp3-dev build-essential libicu-dev zlib1g-dev libtinfo5 libusb-1.0-0 libfcgi-dev libcurl3-gnutls libcurl3

#Создание директорий
mkdir /usr/local/eosio
mkdir /usr/local/eosio/bin
mkdir /usr/local/eosio/etc

#Скачивание софта и его копирование
cd /root
git clone https://github.com/protex-project/solutions-terraform-cloudbuild-gitops.git
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/cleos /usr/local/eosio/bin
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/nodeos /usr/local/eosio/bin
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/etc/config.ini /usr/local/eosio/etc

#Переменные конфигурации
sed 's/initXXX/${producer_name}/' /usr/local/eosio/etc/config.ini
sed 's/pkeyXXX/${producer_pkey}/' /usr/local/eosio/etc/config.ini
sed 's/pubXXX/${producer_pub}/' /usr/local/eosio/etc/config.ini

#Стартовые скрипты
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/backup.sh /root
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/start_nodeos.sh /root

#Очищаем
#rm -rf solutions-terraform-cloudbuild-gitops
