#!/bin/bash

BACKUP="/root/backup"

CURRENTDATE=`date +%Y%m%d%H%M`
OUTPUT="$BACKUP/$CURRENTDATE"

find $BACKUP -name '*.tar' -type f -mtime +7 -exec rm -r -f {} \;

rm /usr/local/eosio/data/snapshots/*.bin
curl -X POST http://127.0.0.1:8888/v1/producer/create_snapshot

mkdir $OUTPUT
cp -r /usr/local/eosio/data/snapshots/*.bin $OUTPUT/snapshot.bin
cp -r /usr/local/eosio/data/blocks/blocks.log $OUTPUT
tar -c -f $OUTPUT.tar $OUTPUT
rm -rf $OUTPUT

rm $BACKUP/latest.tar
ln -s $OUTPUT.tar $BACKUP/latest.tar

/usr/bin/killall -TERM nodeos
/bin/sleep 5

cp eosio/bin/cleos /usr/local/eosio/bin
cp eosio/bin/nodeos /usr/local/eosio/bin
cp eosio/bin/keosd /usr/local/eosio/bin

/bin/mkdir -p /root/restore
/bin/tar xvf $BACKUP/latest.tar --strip-components 2 -C /root/restore

if test -f "/root/restore/blocks.log"; then
 /bin/rm -Rf /usr/local/eosio/data
 /bin/mkdir -p /usr/local/eosio/data
 /bin/mkdir -p /usr/local/eosio/data/blocks
 /bin/mv /root/restore/blocks.log /usr/local/eosio/data/blocks

 /usr/bin/screen -d -m -A -S nodeos -L -Logfile /var/log/nodeos.log \
  /usr/local/eosio/bin/nodeos \
  --snapshot=/root/restore/snapshot.bin \
  --data-dir /usr/local/eosio/data \
  --config-dir /usr/local/eosio/etc
else
 /usr/bin/screen -d -m -A -S nodeos -L -Logfile /var/log/nodeos.log \
  /usr/local/eosio/bin/nodeos \
  --data-dir /usr/local/eosio/data \
  --config-dir /usr/local/eosio/etc
fi
