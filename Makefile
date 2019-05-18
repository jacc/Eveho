FINALPACKAGE = 1
GO_EASY_ON_ME = 0
export ARCHS = arm64e arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Eveho
Eveho_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Sileo"
