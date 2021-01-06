#Not really using this… although I probably should -HM 10/2/2014
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := miniupnpc1_5_static

LOCAL_MODULE_FILENAME := miniupnpc15

MY_SOURCES_C := $(wildcard $(LOCAL_PATH)/*.c)

LOCAL_SRC_FILES := $(MY_SOURCES_C:$(LOCAL_PATH)/%=%)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)

LOCAL_C_INCLUDES := $(LOCAL_PATH)

LOCAL_CFLAGS := -std=c99

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)