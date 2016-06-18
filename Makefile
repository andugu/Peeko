include theos/makefiles/common.mk

ARCHS = armv7 arm64

LDFLAGS += -F. -framework Security -current_version 1.0 -compatibility_version 1.0 -framework UIKit -framework AudioToolbox

TWEAK_NAME = Peeko
Peeko_FILES = Tweak.xm
Peeko_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk