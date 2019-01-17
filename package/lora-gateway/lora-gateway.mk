################################################################################
#
# lora-gateway
#
################################################################################

LORA_GATEWAY_VERSION = v5.0.1
LORA_GATEWAY_SITE = $(call github,Lora-net,lora_gateway,$(LORA_GATEWAY_VERSION))
LORA_GATEWAY_LICENSE = Semtech S.A. 
LORA_GATEWAY_LICENSE_FILES = LICENSE
LORA_GATEWAY_INSTALL_STAGING = YES

define LORA_GATEWAY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) all
endef

define LORA_GATEWAY_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libloragw/libloragw.a $(STAGING_DIR)/usr/lib/lora_gateway/libloragw/libloragw.a

	$(foreach f,$(notdir $(wildcard $(@D)/libloragw/inc/*)),
    	$(INSTALL) -m 0644 -D $(@D)/libloragw/inc/$(f) $(STAGING_DIR)/usr/include/lora_gateway/libloragw/inc)
endef

ifeq ($(BR2_PACKAGE_LORA_GATEWAY_UTILS), y)
define LORA_GATEWAY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/reset_lgw.sh $(TARGET_DIR)/opt/lora_gateway/libloragw/reset_lgw.sh
	( \
		cd $(LORA_GATEWAY_BUILDDIR) ; \
		for filename in $$(find ./ -name "util_*" -perm 0755 -type f); do \
		$(INSTALL) -m 0755 -D $$filename $(TARGET_DIR)/opt/lora_gateway/utils/`basename $$filename`; \
		done ; \
	)
endef
else	
ifeq ($(BR2_PACKAGE_LORA_GATEWAY), y)
define LORA_GATEWAY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/reset_lgw.sh $(TARGET_DIR)/opt/lora_gateway/libloragw/reset_lgw.sh
endef
endif
endif

$(eval $(generic-package))

