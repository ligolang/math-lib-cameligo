ligo_compiler?=docker run --rm -v "$$PWD":"$$PWD" -w "$$PWD" ligolang/ligo:stable

PROTOCOL_OPT?=

help:
	@echo  'Usage:'
	@echo  '  test            - Run integration tests (written in LIGO)'
	@echo  '  install         - Install LIGO dependencies'
	@echo  ''

.PHONY: install test

install:
	make -C float $@
	make -C rational $@
	@$(ligo_compiler) install

test:
	make -C core $@
	make -C float $@
	make -C rational $@
