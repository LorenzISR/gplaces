# see LICENSE for copyright and license details
PREFIX = /usr/local
CONFDIR = /etc
MANDIR = $(PREFIX)/share/man
ICONDIR = $(PREFIX)/share/icons
APPDIR = $(PREFIX)/share/applications
CC = cc
CFLAGS ?= -O2 -Wall -Wextra -DCONFDIR=\"$(CONFDIR)\"
CFLAGS += $(shell pkg-config --cflags libcurl libssl libcrypto)
LDFLAGS ?=
LDFLAGS += $(shell pkg-config --libs libcurl libssl libcrypto)
OBJ = bestline/bestline.o gplaces.o
BIN = gplaces
CONF = gplaces.conf
MAN = gplaces.1
ICON = gplaces.svg
APP = gplaces.desktop

default: $(OBJ)
	$(CC) $(CFLAGS) -o $(BIN) $(OBJ) $(LDFLAGS)

.PHONY: clean
clean:
	@rm -f $(BIN) $(OBJ)

install: default
	@mkdir -p $(DESTDIR)$(PREFIX)/bin/
	@install $(BIN) $(DESTDIR)$(PREFIX)/bin/${BIN}
	@mkdir -p $(DESTDIR)$(PREFIX)$(CONFDIR)
	@install $(CONF) $(DESTDIR)$(CONFDIR)/${CONF}
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@install $(MAN) $(DESTDIR)$(MANDIR)/man1/${MAN}
	@mkdir -p $(DESTDIR)$(ICONDIR)/hicolor/scalable/apps
	@install $(ICON) $(DESTDIR)$(ICONDIR)/hicolor/scalable/apps/${ICON}
	@mkdir -p $(DESTDIR)$(APPDIR)
	@install $(APP) $(DESTDIR)$(APPDIR)/${APP}

uninstall:
	@rm -f $(DESTDIR)$(PREFIX)/bin/$(BIN)
	@rm -f $(DESTDIR)$(PREFIX)/etc/$(CONF)
