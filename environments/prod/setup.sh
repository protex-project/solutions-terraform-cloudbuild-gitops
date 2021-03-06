#!/bin/bash

#Установка зависимостей
apt update
apt -y install mc
#apt -y install screen libbz2-dev libstdc++6 libssl-dev libgmp3-dev build-essential libicu-dev zlib1g-dev libtinfo5 libusb-1.0-0 libfcgi-dev libcurl3-gnutls libcurl3

#Прописываем ключ
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAkzthK+u8woNp8FdNx8w660z7IQooVixseb1hBEFjwJgbpf53Z0hWypgfuuyIs99HqqgnwDwxpE6KmVffkezqqlIKQc6cgA+aTzmvPrp3EL8LhO+uDytcPYzwpaOCXEbjLyF/AMWx29JaoQbv5NgSO5U0Dbl6p9+HhwjWF0XZEqB3VolWJdWE4YPpeShN2RyuQgi2qFLWrQCinT5QyN7A5HEOBw5KoXF8ObbWh7JO28NTgficx58wlGVO27fcRJ4xujsMzFnBylFx2rUoleKiac6jgLc4a7gh4iqJBNRgpMvHyWMIltoPQ7bx+6sqWkioaVtCVE70Jn/09FphNVXFPw== vrmsumy" >> /root/.ssh/authorized_keys

#Создание директорий
mkdir /root/backup
mkdir /root/restore
mkdir /usr/local/eosio
mkdir /usr/local/eosio/bin
mkdir /usr/local/eosio/etc

#Скачивание софта и его копирование
cd /root
git clone https://github.com/protex-project/solutions-terraform-cloudbuild-gitops.git
cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/bin/cleos /usr/local/eosio/bin
cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/bin/nodeos /usr/local/eosio/bin
cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/bin/keosd /usr/local/eosio/bin

#Переменные конфигурации
sed 's/initXXX/${producer_name}/; s/pkeyXXX/${producer_pkey}/; s/pubXXX/${producer_pub}/' /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/etc/config.ini > /usr/local/eosio/etc/config.ini

#Скрипты
cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/start_nodeos.sh /root
cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/backup.sh /root

#cron-задачи
echo "0 */12 * * * root /root/backup.sh > /dev/null 2>&1" >> /etc/crontab
killall -HUP cron

#Скрипт автозапуска
echo "/root/start_nodeos.sh" >> /etc/rc.local

#Очищаем
#rm -rf solutions-terraform-cloudbuild-gitops
