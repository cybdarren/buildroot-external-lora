################################################################################
#
# packet-forwarder
#
################################################################################

PACKET_FORWARDER_VERSION = v4.0.1
PACKET_FORWARDER_SITE = $(call github,Lora-net,packet_forwarder,$(PACKET_FORWARDER_VERSION))
PACKET_FORWARDER_LICENSE = Semtech S.A. 
PACKET_FORWARDER_LICENSE_FILES = LICENSE
PACKET_FORWARDER_DEPENDENCIES = lora-gateway


define PACKET_FORWARDER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) LGW_PATH="$(STAGING_DIR)/usr/include/lora_gateway/libloragw" -C $(@D) all
endef

ifeq ($(BR2_PACKAGE_PACKET_FORWARDER_UTILS), y)
define PACKET_FORWARDER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lora_pkt_fwd/lora_pkt_fwd $(TARGET_DIR)/opt/packet_forwarder/lora_pkt_fwd
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/*.json $(TARGET_DIR)/opt/packet_forwarder/
	$(INSTALL) -m 0755 -D $(PACKET_FORWARDER_PKGDIR)/S99pkt_fwd $(TARGET_DIR)/etc/init.d/S99pkt_fwd	
	$(INSTALL) -d $(TARGET_DIR)/opt/packet_forwarder/cfg
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/cfg/global_conf* $(TARGET_DIR)/opt/packet_forwarder/cfg/
	$(INSTALL) -D -m 0755 $(@D)/lora_pkt_fwd/update_gwid.sh $(TARGET_DIR)/opt/packet_forwarder/update_gwid.sh
	( \
		cd $(PACKET_FORWARDER_BUILDDIR) ; \
		for filename in $$(find ./ -name "util_*" -perm 0755 -type f); do \
		$(INSTALL) -m 0755 -D $$filename $(TARGET_DIR)/opt/packet_forwarder/util/`basename $$filename`; \
		done ; \
	)
endef
else	
ifeq ($(BR2_PACKAGE_PACKET_FORWARDER), y)
define PACKET_FORWARDER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lora_pkt_fwd/lora_pkt_fwd $(TARGET_DIR)/opt/packet_forwarder/lora_pkt_fwd
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/*.json $(TARGET_DIR)/opt/packet_forwarder/
	$(INSTALL) -m 0755 -D $(PACKET_FORWARDER_PKGDIR)/S99pkt_fwd $(TARGET_DIR)/etc/init.d/S99pkt_fwd	
	$(INSTALL) -d $(TARGET_DIR)/opt/packet_forwarder/cfg
	$(INSTALL) -D -m 0644 $(@D)/lora_pkt_fwd/cfg/global_conf* $(TARGET_DIR)/opt/packet_forwarder/cfg/
	$(INSTALL) -D -m 0755 $(@D)/lora_pkt_fwd/update_gwid.sh $(TARGET_DIR)/opt/packet_forwarder/update_gwid.sh
endef
endif
endif



$(eval $(generic-package))

