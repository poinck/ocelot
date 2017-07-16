# ocelot (changes) by André Klausnitzer, CC0
# monsterwm (original) by c00kiemon5ter, MIT (see LICENSE-mit)
# Makefile for ocelot

VERSION = 1.0.1
WMNAME  = ocelot

PREFIX ?= /usr/local
BINDIR ?= ${PREFIX}/bin
MANPREFIX = ${PREFIX}/share/man

X11INC = -I/usr/X11R6/include
X11LIB = -L/usr/X11R6/lib -lX11

INCS = -I. -I/usr/include ${X11INC}
LIBS = -L/usr/lib -lc ${X11LIB}

CFLAGS   = -std=c99 -pedantic -Wall -Wextra ${INCS} -DVERSION=\"${VERSION}\"
LDFLAGS  = ${LIBS}

CC 	 = cc
EXEC = ${WMNAME}

SRC = ${WMNAME}.c
OBJ = ${SRC:.c=.o}

ADDITIONAL_BINARIES=obattery obrightness ocelot2dzen2 ocelotbar ocollector odesktop oload olock olocker omenu oray oterminal otest otime otmc oupdates ovolume oyay reset-ocollector.sh startocelot

all: CFLAGS += -Os
all: LDFLAGS += -s
all: options ${WMNAME}

debug: CFLAGS += -O0 -g
debug: options ${WMNAME}

options:
	@echo ${WMNAME} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

${WMNAME}: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -fv ${WMNAME} ${OBJ} ${WMNAME}-${VERSION}.tar.gz

install: all
	@echo installing executable files to ${DESTDIR}${PREFIX}/bin
	@install -Dm755 ${WMNAME} ${DESTDIR}${PREFIX}/bin/${WMNAME}
	@for binary in ${ADDITIONAL_BINARIES}; do install -Dm755 bin/$$binary ${DESTDIR}${PREFIX}/bin/$$binary; done

uninstall:
	@echo removing executable files from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/${WMNAME}
	@for binary in ${ADDITIONAL_BINARIES}; do rm -f ${DESTDIR}${PREFIX}/bin/$$binary; done

.PHONY: all options clean install uninstall
