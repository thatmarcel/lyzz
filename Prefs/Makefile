include $(THEOS)/makefiles/common.mk

SDKVERSION = 11.2
SYSROOT = /opt/theos/sdks/iPhoneOS11.2.sdk
ARCHS = arm64 arm64e


INSTALL_TARGETS_PROCESS = Preferences

BUNDLE_NAME = LyzzPrefs

$(BUNDLE_NAME)_FILES = $(wildcard *.m)
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_FRAMEWORKS += UIKit
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_LIBRARIES += appearancecell
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs Alderis
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(BUNDLE_NAME).plist$(ECHO_END)
