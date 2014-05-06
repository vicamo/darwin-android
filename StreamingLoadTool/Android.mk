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
LOCAL_MODULE := darwin-StreamingLoadTool

LOCAL_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    StreamingLoadTool \
    OSMemoryLib \
    RTSPClientLib \
    RTCPUtilitiesLib \
    APICommonCode \
    CommonUtilitiesLib \
    PrefsSourceLib \
    APIStubLib \
    RTPMetaInfoLib \
  ) \
  $(empty)

LOCAL_CPPFLAGS := \
  -include PlatformHeader.h \
  $(empty)

LOCAL_SRC_FILES := \
  StreamingLoadTool/StreamingLoadTool.cpp \
  SafeStdLib/InternalStdLib.cpp \
  RTSPClientLib/ClientSocket.cpp \
  RTSPClientLib/RTSPClient.cpp \
  RTSPClientLib/ClientSession.cpp \
  RTCPUtilitiesLib/RTCPAckPacket.cpp \
  RTCPUtilitiesLib/RTCPAPPNADUPacket.cpp \
  RTCPUtilitiesLib/RTCPAPPPacket.cpp \
  RTCPUtilitiesLib/RTCPAPPQTSSPacket.cpp \
  RTCPUtilitiesLib/RTCPPacket.cpp \
  RTCPUtilitiesLib/RTCPSRPacket.cpp \
  PrefsSourceLib/FilePrefsSource.cpp \
  APICommonCode/SDPSourceInfo.cpp \
  APICommonCode/SourceInfo.cpp \
  RTPMetaInfoLib/RTPMetaInfoPacket.cpp \
  OSMemoryLib/OSMemory.cpp \
  $(empty)

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := StreamingLoadTool
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_LIBRARIES := \
  darwin-StreamingLoadTool \
  darwin-CommonUtilitiesLib \
  $(empty)
include $(BUILD_EXECUTABLE)

$(call darwin-add-to-targets,$(LOCAL_MODULE),executable)
