#!/bin/bash

#Установка зависимостей
apt update
apt -y install mc python-pip fabric
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
git clone --branch prod https://github.com/protex-project/solutions-terraform-cloudbuild-gitops.git
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/cleos /usr/local/eosio/bin
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/nodeos /usr/local/eosio/bin
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/bin/keosd /usr/local/eosio/bin

#Переменные конфигурации
sed 's/initXXX/${producer_account}/; s/pkeyXXX/${producer_pkey}/; s/pubXXX/${producer_pub}/' /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/etc/config.ini > /usr/local/eosio/etc/config.ini

#Скрипты
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/start_nodeos.sh /root
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/backup.sh /root
cp /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/credentials.json /root
sed 's/nodeXXX/${producer_name}/; s/initXXX/${producer_account}/; s/peersXXX/${producer_peers}/' /root/solutions-terraform-cloudbuild-gitops/environments/prod/eosio/fabfile.py > /root/fabfile.py

#cron-задачи
echo "0 */12 * * * root /root/backup.sh > /dev/null 2>&1" >> /etc/crontab
killall -HUP cron

#Логи
echo -e "/var/log/nodeos.log {\n rotate 14\n daily\n compress\n missingok\n notifempty\n}" >> /etc/logrotate.d/nodeos

#Скрипт автозапуска
echo "/root/start_nodeos.sh" >> /etc/rc.local

#Очищаем
#rm -rf solutions-terraform-cloudbuild-gitops
