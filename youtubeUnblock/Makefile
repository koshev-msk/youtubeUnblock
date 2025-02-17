# This file is used by OpenWRT SDK buildsystem to package the application for routers.

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=youtubeUnblock
PKG_VERSION:=1.0.0
PKG_REV:=2d1b58bc6d6dbe397dee1dd1729129bc4871b890
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/Waujito/youtubeUnblock.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=services
  CATEGORY:=Networking
  TITLE:=youtubeUnblock
  DEPENDS:=+libpthread
  URL:=https://github.com/Waujito/youtubeUnblock
  MAINTAINER:=Vadim Vetrov <vetrovvd@gmail.com>
  VERSION:=$(PKG_VERSION)-$(BOARD)-$(PKG_RELEASE)
endef

define KernelPackage/$(PKG_NAME)
  SECTION:=net
  CATEGORY:=Networking
  TITLE:=youtubeUnblock kernel module
  VERSION:=$(LINUX_VERSION)+$(PKG_VERSION)-$(BOARD)-$(PKG_RELEASE)
  FILES:=$(PKG_BUILD_DIR)/kyoutubeUnblock.$(LINUX_KMOD_SUFFIX)
  URL:=https://github.com/Waujito/youtubeUnblock
  AUTOLOAD:=$(call AutoLoad,33,kyoutubeUnblock)
  MAINTAINER:=Vadim Vetrov <vetrovvd@gmail.com>
endef

include $(INCLUDE_DIR)/kernel-defaults.mk

define Package/youtubeUnblock/description
	Bypasses Googlevideo detection systems that relies on SNI
endef

define Build/Prepare
        $(Build/Prepare/Default)
	$(Build/Patch)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		PATH="$(TARGET_PATH)" \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		CROSS_COMPILE_PLATFORM="$(TARGET_CROSS:-=)"
		
	$(KERNEL_MAKE) -C $(LINUX_DIR) \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		M="$(PKG_BUILD_DIR)" \
		CONFIG_kyoutubeUnblock=m \
		modules	
endef

define Package/youtubeUnblock/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/youtubeUnblock $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/youtubeUnblock $(1)/etc/init.d/youtubeUnblock
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/99-youtubeUnblock.sh $(1)/etc/uci-defaults/99-youtubeUnblock.sh
	$(INSTALL_DIR) $(1)/usr/share/nftables.d/ruleset-post/
	$(INSTALL_DATA) ./files/nftables.d/537-youtubeUnblock.nft $(1)/usr/share/nftables.d/ruleset-post/537-youtubeUnblock.nft
endef

$(eval $(call BuildPackage,youtubeUnblock))
$(eval $(call KernelPackage,youtubeUnblock))
