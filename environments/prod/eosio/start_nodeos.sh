#!/bin/bash

screen -S nodeos -L -Logfile /var/log/nodeos.log /usr/local/eosio/bin/nodeos --data-dir /usr/local/eosio/data -c /usr/local/eosio/etc/config.ini

