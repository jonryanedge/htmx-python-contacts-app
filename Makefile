# Include variable from .envrc file
#include .envrc

# Include server ops 
#include ./server/Makefile

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
	python3 -m venv venv

## run: run the web application in venv
.PHONY: run
run:
	. venv/bin/activate && python app.py

## install: activate virtual environment & install reqs
.PHONY: install
install:
	. venv/bin/activate && pip install -r requirements.txt


