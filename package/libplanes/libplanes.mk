################################################################################
#
# libplanes
#
################################################################################

LIBPLANES_VERSION = a3e2f9315f0ed55655f396eb1cf13ccf41ca5ba9
LIBPLANES_SITE = https://github.com/linux4sam/libplanes
LIBPLANES_SITE_METHOD = git
LIBPLANES_LICENSE = MIT
LIBPLANES_LICENSE_FILES = COPYING
LIBPLANES_DEPENDENCIES = libdrm cairo cjson lua
ifeq ($(BR2_PACKAGE_DIRECTFB),y)
LIBPLANES_DEPENDENCIES += directfb
endif

LIBPLANES_INSTALL_STAGING = YES

define LIBPLANES_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
LIBPLANES_POST_PATCH_HOOKS += LIBPLANES_RUN_AUTOGEN

define LIBPLANES_INSTALL_MENU
        $(INSTALL) -m 0644 -D $(@D)/scripts/planes.png \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/resources/planes.png
        $(INSTALL) -m 0644 -D $(@D)/scripts/09-planes.xml \
                $(TARGET_DIR)/opt/ApplicationLauncher/applications/xml/09-planes.xml
        $(INSTALL) -m 0755 -D $(@D)/scripts/planes-loop.sh \
                $(TARGET_DIR)/opt/planes/planes-loop.sh
        $(INSTALL) -m 0755 -D $(@D)/python/examples/splash.py \
                $(TARGET_DIR)/usr/share/planes/splash.py
endef

LIBPLANES_POST_INSTALL_TARGET_HOOKS += LIBPLANES_INSTALL_MENU

$(eval $(autotools-package))