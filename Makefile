SRC = lualib/
PREFIX ?= /usr/local
LUA_VERSION ?= 5.4
INSTALL_DIR = $(PREFIX)/lib/lua/$(LUA_VERSION)/

build:
	gcc -O3 -Wall -shared -fPIC -o lualib/core.so src/lualib.c -I/usr/include/lua$(LUA_VERSION)

install: build
	mkdir -p "$(DESTDIR)$(INSTALL_DIR)"
	cp -r $(SRC) "$(DESTDIR)$(INSTALL_DIR)"

uninstall:
	rm -rf "$(DESTDIR)$(INSTALL_DIR)lualib"

clean:
	rm lualib/core.so

test: test/*
	@for file in $^ ; do \
		echo -e "Running $$file"; \
		LUA_CPATH="./?.so;./?.lua" lua "$$file"; \
	done

.PHONY: build install uninstall test
