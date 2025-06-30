SRC = lualib/
INSTALL_DIR = /usr/local/lib/lua/5.4/

install:
	mkdir -p $(INSTALL_DIR)
	cp -r $(SRC) $(INSTALL_DIR)

.PHONY: install
