# First include the GoogleTest library module definitions.
include $(LOCAL_PATH)/distrib/googletest/Android.mk

EMULATOR_UNITTESTS_SOURCES := \
  android/avd/util_unittest.cpp \
  android/base/containers/HashUtils_unittest.cpp \
  android/base/containers/PodVector_unittest.cpp \
  android/base/containers/PointerSet_unittest.cpp \
  android/base/containers/ScopedPointerSet_unittest.cpp \
  android/base/containers/StringVector_unittest.cpp \
  android/base/containers/TailQueueList_unittest.cpp \
  android/base/EintrWrapper_unittest.cpp \
  android/base/files/PathUtils_unittest.cpp \
  android/base/files/ScopedFd_unittest.cpp \
  android/base/files/ScopedStdioFile_unittest.cpp \
  android/base/files/Stream_unittest.cpp \
  android/base/Log_unittest.cpp \
  android/base/memory/LazyInstance_unittest.cpp \
  android/base/memory/MallocUsableSize_unittest.cpp \
  android/base/memory/ScopedPtr_unittest.cpp \
  android/base/memory/QSort_unittest.cpp \
  android/base/misc/HttpUtils_unittest.cpp \
  android/base/misc/StringUtils_unittest.cpp \
  android/base/misc/Utf8Utils_unittest.cpp \
  android/base/sockets/ScopedSocket_unittest.cpp \
  android/base/sockets/SocketDrainer_unittest.cpp \
  android/base/sockets/SocketWaiter_unittest.cpp \
  android/base/String_unittest.cpp \
  android/base/StringFormat_unittest.cpp \
  android/base/StringView_unittest.cpp \
  android/base/synchronization/ConditionVariable_unittest.cpp \
  android/base/synchronization/Lock_unittest.cpp \
  android/base/synchronization/MessageChannel_unittest.cpp \
  android/base/system/System_unittest.cpp \
  android/base/threads/Thread_unittest.cpp \
  android/base/threads/ThreadStore_unittest.cpp \
  android/base/Uri_unittest.cpp \
  android/base/Version_unittest.cpp \
  android/emulation/bufprint_config_dirs_unittest.cpp \
  android/emulation/ConfigDirs_unittest.cpp \
  android/emulation/control/LineConsumer_unittest.cpp \
  android/emulation/CpuAccelerator_unittest.cpp \
  android/emulation/serial_line_unittest.cpp \
  android/filesystems/ext4_utils_unittest.cpp \
  android/filesystems/fstab_parser_unittest.cpp \
  android/filesystems/partition_types_unittest.cpp \
  android/filesystems/ramdisk_extractor_unittest.cpp \
  android/filesystems/testing/TestSupport.cpp \
  android/kernel/kernel_utils_unittest.cpp \
  android/metrics/metrics_reporter_unittest.cpp \
  android/metrics/metrics_reporter_ga_unittest.cpp \
  android/metrics/metrics_reporter_toolbar_unittest.cpp \
  android/metrics/StudioHelper_unittest.cpp \
  android/opengl/EmuglBackendList_unittest.cpp \
  android/opengl/EmuglBackendScanner_unittest.cpp \
  android/opengl/emugl_config_unittest.cpp \
  android/opengl/GpuFrameBridge_unittest.cpp \
  android/qt/qt_path.cpp \
  android/qt/qt_path_unittest.cpp \
  android/qt/qt_setup.cpp \
  android/qt/qt_setup_unittest.cpp \
  android/telephony/debug.c \
  android/telephony/gsm_unittest.cpp \
  android/telephony/gsm.c \
  android/telephony/sms.c \
  android/telephony/sms_unittest.cpp \
  android/update-check/UpdateChecker_unittest.cpp \
  android/update-check/VersionExtractor_unittest.cpp \
  android/utils/aconfig-file_unittest.cpp \
  android/utils/bufprint_unittest.cpp \
  android/utils/dirscanner_unittest.cpp \
  android/utils/eintr_wrapper_unittest.cpp \
  android/utils/file_data_unittest.cpp \
  android/utils/format_unittest.cpp \
  android/utils/host_bitness_unittest.cpp \
  android/utils/path_unittest.cpp \
  android/utils/property_file_unittest.cpp \
  android/utils/string_unittest.cpp \
  android/utils/x86_cpuid_unittest.cpp \
  android/wear-agent/PairUpWearPhone_unittest.cpp \
  android/wear-agent/testing/WearAgentTestUtils.cpp \
  android/wear-agent/WearAgent_unittest.cpp \

ifeq (windows,$(HOST_OS))
EMULATOR_UNITTESTS_SOURCES += \
  android/base/files/ScopedHandle_unittest.cpp \
  android/base/system/Win32Utils_unittest.cpp \
  android/utils/win32_cmdline_quote_unittest.cpp \

endif

$(call start-emulator-program, emulator$(HOST_SUFFIX)_unittests)
LOCAL_C_INCLUDES += $(EMULATOR_GTEST_INCLUDES) $(LOCAL_PATH)/include  $(LIBXML2_INCLUDES)
LOCAL_LDLIBS += $(EMULATOR_GTEST_LDLIBS) $(LIBCURL_LDLIBS) $(LIBXML2_LDLIBS)
LOCAL_SRC_FILES := $(EMULATOR_UNITTESTS_SOURCES)
LOCAL_CFLAGS += -O0 -I$(LIBCURL_INCLUDES)
LOCAL_STATIC_LIBRARIES += \
    libandroid-wear-agent \
    emulator-common \
    emulator-libext4_utils \
    emulator-libsparse \
    emulator-libselinux \
    emulator-zlib \
    emulator-libgtest
$(call end-emulator-program)


# Android skin unit tests

ANDROID_SKIN_UNITTESTS := \
    android/skin/keycode_unittest.cpp \
    android/skin/keycode-buffer_unittest.cpp \
    android/skin/rect_unittest.cpp \
    android/skin/region_unittest.cpp \

$(call start-emulator-program, android$(HOST_SUFFIX)_skin_unittests)
LOCAL_C_INCLUDES += $(EMULATOR_GTEST_INCLUDES) $(LOCAL_PATH)/include
LOCAL_LDLIBS += $(EMULATOR_GTEST_LDLIBS) $(LIBCURL_LDLIBS)
LOCAL_SRC_FILES := $(ANDROID_SKIN_UNITTESTS)

ifdef EMULATOR_USE_QT
LOCAL_SRC_FILES += \
    android/gps/GpxParser_unittest.cpp \
    android/gps/internal/GpxParserInternal_unittest.cpp \
    android/gps/internal/KmlParserInternal_unittest.cpp \
    android/gps/KmlParser_unittest.cpp \

LOCAL_C_INCLUDES += $(LIBXML2_INCLUDES)
LOCAL_LDLIBS += $(LIBXML2_LDLIBS)
endif  # EMULATOR_USE_QT

LOCAL_CFLAGS += -O0 -I$(LIBCURL_INCLUDES)
LOCAL_STATIC_LIBRARIES += \
    emulator-libui \
    emulator-common \
    emulator-libgtest
$(call end-emulator-program)
