################################################################################
#
# packet-forwarder
#
################################################################################

PACKET_FORWARDER_VERSION = v4.0.1
PACKET_FORWARDER_SITE = $(call github,Lora-net,packet_forwarder,$(PACKET_FORWARDER_VERSION))
PACKET_FORWARDER_LICENSE = Semtech S.A. 
PACKET_FORWARDER_LICENSE_FILES = LICENSE
PACKET_FORWARDER_INSTALL_STAGING = YES
PACKET_FORWARDER_DEPENDENCIES = lora-gateway

define PACKET_FORWARDER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) all
endef

ifeq ($(BR2_PACKAGE_PACKET_FORWARDER), y)
define PACKET_FORWARDER_INSTALL_TARGET_CMDS
	echo "###########################"
	echo "Installing packet forwarder"
	echo "###########################"
endef
endif

$(eval $(generic-package))

