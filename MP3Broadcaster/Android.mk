# Copyright 2013, You-Sheng Yang
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# LOCAL_PATH should always set to $(DARWIN_TOPSRCDIR)
#LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := darwin-MP3Broadcaster
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    MP3Broadcaster \
    QTFileLib \
    OSMemoryLib \
    APIStubLib \
    APICommonCode \
    CommonUtilitiesLib \
    PlaylistBroadcaster.tproj \
  ) \
  $(empty)

LOCAL_CPPFLAGS := \
  -include PlatformHeader.h \
  -include revision.h \
  -D__USE_MAX_PRINTF__ \
  $(empty)

LOCAL_SRC_FILES := \
  CommonUtilitiesLib/daemon.c \
  CommonUtilitiesLib/getopt.c \
  $(addprefix MP3Broadcaster/, \
    BroadcasterMain.cpp \
    MP3Broadcaster.cpp \
    MP3BroadcasterLog.cpp \
    MP3FileBroadcaster.cpp \
    MP3MetaInfoUpdater.cpp \
  ) \
  PlaylistBroadcaster.tproj/NoRepeat.cpp \
  PlaylistBroadcaster.tproj/PickerFromFile.cpp \
  PlaylistBroadcaster.tproj/PlaylistPicker.cpp \
  APICommonCode/QTSSRollingLog.cpp \
  SafeStdLib/InternalStdLib.cpp \
  OSMemoryLib/OSMemory.cpp \
  $(empty)

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := MP3Broadcaster
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_LIBRARIES := \
  darwin-MP3Broadcaster \
  darwin-CommonUtilitiesLib \
  $(empty)
include $(BUILD_EXECUTABLE)

$(call darwin-add-to-targets,$(LOCAL_MODULE),executable)
