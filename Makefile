SRC:=$(shell find . -name "*.sh")

all: lint

lint:
	@echo "linting..."
	@shellcheck -S error $(SRC)

.PHONY: all lint
