SRC:=$(shell find . -name "*.sh")

all: lint

lint:
	@echo "linting..."
	@shellcheck $(SRC)

.PHONY: all lint
