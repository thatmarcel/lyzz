include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LyzzAudioExtMonitoring

$(TWEAK_NAME)_FILES = $(wildcard ../Logging/LyzzLogging.m) $(wildcard ../SavedPrefs.m) $(wildcard *.xm)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
