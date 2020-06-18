# To build, clone https://github.com/cbyrne/libappearancecell
# and run 'make' to put the necessary files for libappearancecell
# on your system

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += AudioExt
SUBPROJECTS += AudioExtMonitoring
SUBPROJECTS += LockscreenNowPlayingView
SUBPROJECTS += SpotifyPlayerView
SUBPROJECTS += AppleMusicPlayerView
SUBPROJECTS += Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk

# after-install::
#	install.exec "sbreload"
