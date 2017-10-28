#!/usr/bin/env bash
set -euxo pipefail
IFS=$'\n\t'

# Pretty colors.
red='\033[0;31m'
green='\033[0;32m'
neutral='\033[0m'

declare -r OS=${1:-${OS}}
declare -r PLAYBOOK=${2:-${PLAYBOOK}}
declare -r WORKSPACE=${WORKSPACE:-/tmp/ansible-inspec}

function cleanup() {
  docker-compose stop "${OS}"
  docker-compose rm -f "${OS}"
}

function debug() {
  local container="$(docker-compose ps -q "${OS}")"
  docker exec -it "${container}" /bin/bash
  cleanup
}

function main() {
  docker-compose up -d "${OS}"
  local container="$(docker-compose ps -q "${OS}")"

  # Install role.
  docker cp . "${container}:${WORKSPACE}"
  docker exec -t "${container}" rmdir "/etc/ansible/roles"
  docker exec -t "${container}" ln -s "${WORKSPACE}/roles" "/etc/ansible"

  # Add localhost to ansible hosts group
  playbook_location="${WORKSPACE}/playbooks/${PLAYBOOK}.yml"
  inventory_location="${WORKSPACE}/environments/dev"
  playbook_hosts=`docker exec -t "${container}" grep '  hosts: ' $playbook_location | head -1 | awk '{print $2}'`
  playbook_hosts=${playbook_hosts//$'\r'/} # Remove CRLF returns
  docker exec -t "${container}" sed -i "s/.$playbook_hosts./&\nlocalhost/g" "$inventory_location/hosts"
  docker exec -t "${container}" cat "$inventory_location/hosts"

printf "\n"

  # Validate syntax
  docker exec -t "${container}" env ANSIBLE_FORCE_COLOR=1 ansible-playbook \
              -i "$inventory_location" \
              --syntax-check \
              -vvvv "$playbook_location"

  # Run Playbook.
  docker exec -t "${container}" env ANSIBLE_FORCE_COLOR=1 ansible-playbook \
              -i "$inventory_location" \
              -c local \
              -vvvv "$playbook_location"

  # Run Ansible playbook again (idempotence test).
  idempotence=$(mktemp)
  docker exec -t "${container}" env ANSIBLE_FORCE_COLOR=1 ansible-playbook \
              -i "$inventory_location" \
              -c local \
              -v "$playbook_location" | tee -a $idempotence
  tail $idempotence \
  | grep -q 'changed=0.*failed=0' \
  && (printf ${green}'Idempotence test: pass'${neutral}"\n") \
  || (printf ${red}'Idempotence test: fail'${neutral}"\n" && exit 1)

  # Sleep to allow Services to boot.
  sleep 5

  # Run tests.
  docker exec -t "${container}" inspec exec "${WORKSPACE}/tests/specs/${PLAYBOOK}_spec.rb"
}

#Debug running container
if [ "${@: -1}" = "debug" ] 
then
  trap debug EXIT
else
  trap cleanup EXIT
fi

main "${@}"
