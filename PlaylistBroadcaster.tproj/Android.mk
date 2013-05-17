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
LOCAL_MODULE := PlaylistBroadcaster
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    PlaylistBroadcaster.tproj \
    QTFileLib \
    OSMemoryLib \
    RTSPClientLib \
    APIStubLib \
    APICommonCode \
    CommonUtilitiesLib \
    RTPMetaInfoLib \
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
  $(addprefix PlaylistBroadcaster.tproj/, \
    BCasterTracker.cpp \
    BroadcastLog.cpp \
    NoRepeat.cpp \
    PickerFromFile.cpp \
    PlaylistBroadcaster.cpp \
    PlaylistPicker.cpp \
    playlist_broadcaster.cpp \
    playlist_elements.cpp \
    playlist_lists.cpp \
    playlist_parsers.cpp \
    playlist_SDPGen.cpp \
    playlist_SimpleParse.cpp \
    playlist_utils.cpp \
    PLBroadcastDef.cpp \
    BroadcasterSession.cpp \
  ) \
  APICommonCode/QTSSRollingLog.cpp \
  RTSPClientLib/ClientSocket.cpp \
  RTSPClientLib/RTSPClient.cpp \
  APICommonCode/SDPSourceInfo.cpp \
  APICommonCode/SourceInfo.cpp \
  OSMemoryLib/OSMemory.cpp \
  SafeStdLib/InternalStdLib.cpp \
  RTPMetaInfoLib/RTPMetaInfoPacket.cpp \
  $(empty)

LOCAL_STATIC_LIBRARIES := \
  darwin-QTFileExternalLib \
  darwin-CommonUtilitiesLib \
  $(empty)

include $(BUILD_EXECUTABLE)

$(call darwin-add-to-targets,$(LOCAL_MODULE),executable)
