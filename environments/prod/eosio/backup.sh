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

