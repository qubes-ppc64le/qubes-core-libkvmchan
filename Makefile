PREFIX ?= /usr
SBIN ?= $(PREFIX)/sbin
LIBDIR ?= $(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include

help:
	@echo "make all                   -- build binaries"
	@echo "make clean                 -- cleanup"

all:
	$(MAKE) -C libkvmchan

install:
	install -D libkvmchan/kvmchand ${DESTDIR}$(SBIN)/kvmchand
	install -D libkvmchan/libkvmchan.so ${DESTDIR}$(LIBDIR)/libkvmchan.so
	install -D -m 0644 libkvmchan/libkvmchan.h ${DESTDIR}$(INCLUDEDIR)/libkvmchan.h
	install -D -m 0644 libkvmchan/libkvmchan-priv.h ${DESTDIR}$(INCLUDEDIR)/libkvmchan-priv.h
	install -D -m 0644 libkvmchan/kvmchan.pc ${DESTDIR}$(LIBDIR)/pkgconfig/kvmchan.pc

clean:
	make -C libkvmchan clean
