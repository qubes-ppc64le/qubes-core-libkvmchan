RPM_SPEC_FILES := rpm_spec/libkvmchan.spec

ifeq ($(PACKAGE_SET),dom0)
  RPM_SPEC_FILES += rpm_spec/libkvmchan-host.spec

else ifeq ($(PACKAGE_SET),vm)
  ifneq ($(filter $(DISTRIBUTION), debian qubuntu),)
    DEBIAN_BUILD_DIRS := debian
    ifeq (,$(wildcard $(ORIG_SRC)/PATCHES_APPLIED))
      SOURCE_COPY_IN := source-debian-quilt-copy-in
    endif
  endif

  RPM_SPEC_FILES += rpm_spec/libkvmchan-vm.spec
  ARCH_BUILD_DIRS := archlinux
endif

ifeq ($(PACKAGE_SET),vm)
  WIN_SOURCE_SUBDIRS := windows
  WIN_SLN_DIR := vs2017
  WIN_COMPILER := msbuild
  WIN_OUTPUT_LIBS = bin
  WIN_OUTPUT_HEADERS = ../include
  WIN_BUILD_DEPS = windows-utils
  WIN_PREBUILD_CMD = set_version.bat && powershell -executionpolicy bypass -File set_version.ps1 < nul
endif

source-debian-quilt-copy-in:
	$(shell $(ORIG_SRC)/debian-quilt $(ORIG_SRC)/series.conf $(CHROOT_DIR)/$(DIST_SRC)/debian/patches)

# vim: filetype=make
