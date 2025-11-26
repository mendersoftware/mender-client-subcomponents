SHELL := /bin/bash

ALL_RELEASES := $(sort $(patsubst subcomponents/releases/%.json,%,$(wildcard subcomponents/releases/*.json)))
LATEST_RELEASE := $(shell echo "$(ALL_RELEASES)" | tr ' ' '\n' | sort -V | tail -n1)
RELEASE ?= $(LATEST_RELEASE)

help:
	@echo 'Main commands:'
	@echo '  build                      - Run all build-* targets'
	@echo '  build-inventory-script     - Build the inventory script'
	@echo ''
	@echo 'Building for Mender Client release: $(RELEASE)'
	@echo 'Available versions: $(ALL_RELEASES)'
	@echo 'Use "RELEASE=... make" to specify a release'
	@echo ''
	@echo 'Other commands:'
	@echo '  check-deps                 - Check dependencies'


build: build-inventory-script

build-inventory-script:
	$(eval MENDER_CLIENT_VERSION := $(shell jq -r '.version' subcomponents/releases/$(RELEASE).json))
	MENDER_CLIENT_VERSION=$(MENDER_CLIENT_VERSION) envsubst '$$MENDER_CLIENT_VERSION' < inventory-script/mender-inventory-client-version.in > inventory-script/mender-inventory-client-version

check-dependencies:
	@missing=""; \
	for cmd in jq envsubst; do \
		which $$cmd >/dev/null 2>&1 || missing="$$missing $$cmd"; \
	done; \
	if [ -n "$$missing" ]; then \
		echo "Error: The following required dependencies are missing:$$missing"; \
		exit 1; \
	fi
	@echo "All dependencies are installed"


.PHONY: help
.PHONY: build
.PHONY: build-inventory-script
.PHONY: check-dependencies
