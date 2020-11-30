#!/bin/sh

cat /root/WALLET.PASSWD | /usr/local/eosio/bin/cleos wallet unlock
/usr/local/eosio/bin/cleos push action eosio setprods "prods-4.json" -p eosio@active
