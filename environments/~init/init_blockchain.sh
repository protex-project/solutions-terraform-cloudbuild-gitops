#!/bin/bash

/usr/bin/screen -d -m -A -S nodeos -L -Logfile /var/log/nodeos.log \
 /usr/local/eosio/bin/nodeos -e -p eosio \
  --data-dir /usr/local/eosio/data \
  --plugin eosio::producer_plugin \
  --plugin eosio::producer_api_plugin \
  --plugin eosio::chain_api_plugin \
  --plugin eosio::http_plugin

sleep 5

/usr/local/eosio/bin/cleos wallet create --to-console >> /root/WALLET.PASSWD
/usr/local/eosio/bin/cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

snap install jq
curl -X POST http://127.0.0.1:8888/v1/producer/schedule_protocol_feature_activations -d '{"protocol_features_to_activate": ["0ec7e080177b2c02b278d5088611686b49d739925a92d9bfcacd7fc6b74053bd"]}' | jq

/usr/local/eosio/bin/cleos set contract eosio contracts/eosio.boot -p eosio

/usr/local/eosio/bin/cleos push transaction '{"delay_sec":0,"max_cpu_usage_ms":0,"actions":[{"account":"eosio","name":"activate","data":{"feature_digest":"299dcb6af692324b899b39f16d5a530a33062804e41f09dc97e9f156b4476707"},"authorization":[{"actor":"eosio","permission":"active"}]}]}'

/usr/local/eosio/bin/cleos set contract eosio contracts/eosio.bios -p eosio

/usr/local/eosio/bin/cleos push action eosio setparams '{"params":{ "max_block_net_usage": 1048576, "target_block_net_usage_pct": 1000, "max_transaction_net_usage": 524288, "base_per_transaction_net_usage": 12, "net_usage_leeway": 500, "context_free_discount_net_usage_num": 20, "context_free_discount_net_usage_den": 100, "max_block_cpu_usage": 400000, "target_block_cpu_usage_pct": 2000, "max_transaction_cpu_usage": 200000, "min_transaction_cpu_usage": 60, "max_transaction_lifetime": 3600, "deferred_trx_expiration_window": 600, "max_transaction_delay": 3888000, "max_inline_action_size": 4096, "max_inline_action_depth": 5, "max_authority_depth": 6}}' -p eosio

/usr/local/eosio/bin/cleos create account eosio inita EOS5zCg5bMvi4AWugeKmiQD5iQtjSrGKdSodTPXnQMYNdeDAm7w2N
/usr/local/eosio/bin/cleos create account eosio initb EOS6PNy7RbvX1Tj55N7GXFJbwGCmjuDVFDxC224g36MyWTDsUpzbz
/usr/local/eosio/bin/cleos create account eosio initc EOS7EXJSLeL3nSmweidjDG9tkeimmYQpt7MCjWiEfP6wDzWYJrSkH
/usr/local/eosio/bin/cleos create account eosio initd EOS6W52PxQiFvWPt9DQnK5qdKXdWoJZNWbPdhXE9fBpqx554S2Zre
/usr/local/eosio/bin/cleos create account eosio urcauxpwdrwi EOS6SfutPJK8GqKs9pwrWyJ7j2m796CSSTMzHcbdYHfoXVRGrR5kW EOS8FSQCh4vEsMUjCdedtgfWn6brVhkdsuGc9gUYXiE7B3dDFUwkg
/usr/local/eosio/bin/cleos create account eosio originator2 EOS7Uvnh4AWWYkiNSD4b7YHAwTcnXahSR5VbvB4vd1E6xo7ZG33Gj EOS64tBJqqSbti7sjY6LXea1LMsfHgfHeZp1AWH91e8URT5JJ9cxW
/usr/local/eosio/bin/cleos create account eosio mxwrmyhsjqek EOS6Wp3EuRzPjrkx68MpUs8yiVd7j6kwnZNHridHAr4NLUgsVW2DV EOS6L6mxqJkY5X94aR6hxUqZgC7u1WCcc4yi4mXfdSDHvDoJ3yMKQ
/usr/local/eosio/bin/cleos create account eosio transit2 EOS69AHzy9anm5S8xcv9H9MoGXHWXGKP9mMXXDsEKPEUevv1CwAQM EOS8ehjujYmMiNarxTQhayLsRoW8kgyJt2Rv28iv9Xvw5vdtD3fMx
/usr/local/eosio/bin/cleos create account eosio daoonrfuyyls EOS6KKZd5vsrD5DnkXcZ9n6GYjy72UZA3J3mb4PkdA3cx4qW61KCn EOS5fKvoJAGPGLsbn9r4po2PQFn7zNgaBKB8YPPUYXsbERMnJEwU7
/usr/local/eosio/bin/cleos create account eosio terminator2 EOS7gd1uNqd1rDmU7gYzNkfhJbXBadGLPnHkoYuufuQ4rdMumrC78 EOS7AVQnZMxheL34soWc6TpmkZ6qTpTBxpmUbnjBaeXBMPpEgv8yZ
/usr/local/eosio/bin/cleos create account eosio uwmhzzdhqxzk EOS89V99a2SdavMTxJ3SJSYinBuCqCdQPVJS8mRm2PtLw4KXg9HWy EOS8Aj6QkzANnh7d7rzH6EgTDar7EQDvk8dEZJX8Xj9bxszgtJGHq
/usr/local/eosio/bin/cleos create account eosio protex.price EOS5bRqKqaFKjbR6WHZREoPJxDXZUVAGuJgLW6g6hnopxCA2sgxsi EOS7Zayx9pPWLC6Psdew39eq4Jf6qRyGjrRTNxQFeSdnaMGGVgZaM
/usr/local/eosio/bin/cleos create account eosio protex.shard EOS7WWpD9SCuE48UPvgZMn6FfmLGcy7f9DmXYw1doYuSqThXfdnEm EOS7WWpD9SCuE48UPvgZMn6FfmLGcy7f9DmXYw1doYuSqThXfdnEm
/usr/local/eosio/bin/cleos create account eosio protex.token EOS6SfutPJK8GqKs9pwrWyJ7j2m796CSSTMzHcbdYHfoXVRGrR5kW EOS8FSQCh4vEsMUjCdedtgfWn6brVhkdsuGc9gUYXiE7B3dDFUwkg
