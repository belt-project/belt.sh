SRC:=$(shell find . -name "*.sh")
SHELLCHECK_IGNORE=-e SC2029 -e SC2087

all: lint

lint:
	@echo "linting..."
	@shellcheck $(SHELLCHECK_IGNORE) $(SRC)

.PHONY: all lint
