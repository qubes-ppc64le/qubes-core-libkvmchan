PREFIX ?= /usr
SBINDIR ?= $(PREFIX)/sbin
LIBDIR ?= $(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include
RPMS_DIR = rpm/

help:
	@echo "make all                   -- build binaries"
	@echo "make rpms-vm               -- generate binary rpm packages for VM"
	@echo "make rpms-dom0             -- generate binary rpm packages for Dom0"
	@echo "make clean                 -- cleanup"

rpms-dom0:
	PACKAGE_SET=dom0 rpmbuild --define "_rpmdir $(RPMS_DIR)" -bb rpm_spec/libkvmchan.spec

rpms-vm:
	PACKAGE_SET=vm rpmbuild --define "_rpmdir $(RPMS_DIR)" -bb rpm_spec/libkvmchan.spec

all:
	SYSTEMD=1 $(MAKE) -C libkvmchan

install:
	install -D libkvmchan/kvmchand ${DESTDIR}$(SBINDIR)/kvmchand
	install -D libkvmchan/libkvmchan.so ${DESTDIR}$(LIBDIR)/libkvmchan.so
	install -D -m 0644 libkvmchan/libkvmchan.h ${DESTDIR}$(INCLUDEDIR)/libkvmchan.h
	install -D -m 0644 libkvmchan/libkvmchan-priv.h ${DESTDIR}$(INCLUDEDIR)/libkvmchan-priv.h
	install -D -m 0644 libkvmchan/kvmchan.pc ${DESTDIR}$(LIBDIR)/pkgconfig/kvmchan.pc

clean:
	make -C libkvmchan clean
