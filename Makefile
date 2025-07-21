SRC = lualib/
INSTALL_DIR = /usr/local/lib/lua/5.4/

build:
	gcc -O3 -Wall -shared -fPIC -o lualib/core.so src/lualib.c -I/usr/include/lua5.4

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
