#!/bin/bash
ansible-pull -i localhost, -U https://github.com/geddadalakshman/infra-conf-ansible.git roboshop.yml -e role_name=${var.component} -e env=${env}