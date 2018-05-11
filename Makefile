# ocelot (changes) by André Klausnitzer, CC0
# monsterwm (original) by c00kiemon5ter, MIT (see LICENSE-mit)
# Makefile for ocelot

VERSION = 1.0.2
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

SCRIPTS = obattery obrightness ocollector odesktop oload olock olocker omenu oterminal otime oupdates ovolume startocelot onet ouptime
SCRIPTS_DEST = ${HOME}/bin
SCRIPTS_SRC = ${PWD}/bin

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
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h

${WMNAME}: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -fv ${WMNAME} ${OBJ}

local_install: all
	ln -sf ${PWD}/${WMNAME} ${SCRIPTS_DEST}/${WMNAME}
	for script in ${SCRIPTS} ; do ln -sf ${SCRIPTS_SRC}/$$script ${SCRIPTS_DEST}/$$script ; done

install:
	install -D -m 644 ${WMNAME}.1 ${DESTDIR}${MANPREFIX}/man1/${WMNAME}.1

uninstall:
	rm -fv ${SCRIPTS_DEST}/${WMNAME}
	for script in ${SCRIPTS} ; do rm -f ${SCRIPTS_DESTDIR}/$$script ; done
	rm -fv ${DESTDIR}${MANPREFIX}/man1/${WMNAME}.1

help:
	@echo type \"make\" to compile ${WMNAME} with your current configuration
	@echo type \"make local_install\" to install ${WMNAME} and create symlinks for
	@echo ${WMNAME}-scripts to ${SCRIPTS_DEST}
	@echo type \"make install\" to only copy man-page
