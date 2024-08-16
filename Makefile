# Include variable from .envrc file
include .env

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: confirm
confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

## prep: prepare environment
.PHONY: prep
prep:
	python3 -m venv .venv

## run: run the web application in venv
.PHONY: run
run:
	. .venv/bin/activate && python app.py

## install: activate virtual environment & install reqs
.PHONY: install
install:
	. .venv/bin/activate && pip install -r requirements.txt && pip install waitress

## host/ssh: ssh to host server
.PHONY: host/ssh
host/ssh:
	ssh -i ${USERKEY} root@${HOST}

## host/svc: copy service file to host server
.PHONY: host/svc
host/svc:
	scp -i ${USERKEY} ./${SVC}.service root@${HOST}:/etc/systemd/system/${SVC}.service

## host/start: start service
.PHONY: host/start
host/start:
	ssh -i ${USERKEY} root@${HOST} 'systemctl start ${SVC}.service'

## host/stop: stop service
.PHONY: host/stop
host/stop:
	ssh -i ${USERKEY} root@${HOST} 'systemctl stop ${SVC}.service'

