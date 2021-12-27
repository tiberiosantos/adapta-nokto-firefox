PROJECT   := adapta-nokto-theme
BUILD_DIR := build
FILES     := manifest.json icon.svg
VERSION   := $(shell awk -F\" '/"version"/ {print $$4}' theme.json)
DEST      := ${BUILD_DIR}/${PROJECT}-${VERSION}.xpi

ifeq ($(shell type tput >/dev/null 2>&1 && echo 1),1)
CYAN  := $(shell tput -Txterm setaf 6)
RED   := $(shell tput -Txterm setaf 1)
RESET := $(shell tput -Txterm sgr0)
endif

.PHONY: all

all:
	@echo -n '[${CYAN}*${RESET}] Generating theme package ... '
	@mkdir -p ${BUILD_DIR}
	$(shell cat theme.json | jq -c > manifest.json)
	@zip -q ${DEST} ${FILES}
	@rm manifest.json
	@echo 'Done!'
	@echo '	${DEST}'

clean:
	@echo -n '[${RED}*${RESET}] Removing theme package ... '
	@rm -rf ${BUILD_DIR}
	@echo 'Done!'
