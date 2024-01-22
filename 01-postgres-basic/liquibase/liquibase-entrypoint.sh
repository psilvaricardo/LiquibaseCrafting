#!/bin/bash
set -e

/usr/local/bin/wait-for-it.sh postgres:5432 -- liquibase update --changeLogFile=/liquibase/changelog/changelog.xml --url=jdbc:postgresql://postgres:5432/testing --username=testuser --password=docker
