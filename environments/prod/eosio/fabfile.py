from fabric.api import *
from google.cloud import storage
import json

env.hosts = ['127.0.0.1'] #адрес сервера
myname    = 'nodeXXX'
myaccount = 'initXXX'
mypeers   = 'peersXXX'

def get_myextip():
 storage_client = storage.Client.from_service_account_json('credentials.json')
 bucket = storage_client.get_bucket('protexbc-tfstate')

 blob = bucket.get_blob('environments/prod/default.tfstate')
 tfstate = json.loads(blob.download_as_string())
 return tfstate.outputs.ips.value.

def checkout():
 with cd('/root/solutions-terraform-cloudbuild-gitops'):
  run('git pull')

def stop():
 run('/root/backup.sh')
 run('killall -TERM nodeos')

def start():
 run('/root/start_nodeos.sh')

def update():
 run('cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/bin/cleos /usr/local/eosio/bin')
 run('cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/bin/nodeos /usr/local/eosio/bin')
 run('cp /root/solutions-terraform-cloudbuild-gitops/environments/node/eosio/bin/keosd /usr/local/eosio/bin')

def deploy():
 checkout()
 stop()
 update()
 start()
