.DEFAULT_GOAL := build

UFBT ?= ufbt
FW_VERSION ?= 1.4.3
UFBT_HOME ?= $(CURDIR)/.ufbt
export FW_VERSION
export UFBT_HOME

.PHONY: help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  ${MAKE} \033[36m<target>\033[0m\n\nTargets:\n"} /^[%0-9a-zA-Z_/-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: sdk
sdk:  ## Fetch the pinned Flipper SDK (FW_VERSION)
	./sdk

.PHONY: build
build: sdk  ## Build the FAP into dist/
	$(UFBT)

.PHONY: clean
clean: sdk  ## Remove build artefacts
	$(UFBT) -c
	rm -rf dist

.PHONY: launch
launch: sdk  ## Build, upload and launch on a connected Flipper
	$(UFBT) launch

.PHONY: screen
screen:  ## Capture the Flipper screen over USB to /tmp/ducobox-screen.png
	./screen

.PHONY: update
update:  ## Re-fetch the pinned Flipper SDK
	./sdk --force