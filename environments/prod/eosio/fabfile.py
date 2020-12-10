from fabric.api import *

env.hosts = ['127.0.0.1'] #адрес сервера

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
