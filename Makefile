SRC = lualib/
PREFIX ?= /usr/local/
LUA_VERSION ?= 5.4
INSTALL_DIR = bin/
INSTALL_DIR = $(PREFIX)lib/lua/$(LUA_VERSION)/

build:
	gcc -O3 -Wall -shared -fPIC -o lualib/core.so src/lualib.c -I/usr/include/lua$(LUA_VERSION)

install: build
	mkdir -p $(INSTALL_DIR)
	cp -r $(SRC) $(INSTALL_DIR)

clean:
	rm lualib/core.so

test: test/*
	@for file in $^ ; do \
		echo -e "Running $$file"; \
		LUA_CPATH="./?.so;./?.lua" lua "$$file"; \
	done

.PHONY: install build test
