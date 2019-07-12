#!/bin/bash
check_status() {
  if [ $1 != 0 ]; then
    echo
    echo $2
    exit $1
  fi
}
echo 'Trying to create kubernetes master node on cluster...'
ansible-playbook master/provisioning.yml -i master/assets/hosts
check_status $? 'Error to create kubernetes master node on cluster.'

echo 'Trying to create kubernetes workers node on cluster...'
ansible-playbook worker/provisioning.yml -i worker/assets/hosts --ask-become-pass
check_status $? 'Error to create kubernetes workers node on cluster.'