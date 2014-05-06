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

LOCAL_PATH := $(call my-dir)

DARWIN_TOPSRCDIR := $(LOCAL_PATH)
DARWIN_INSTALLED_MODULE_DIR := $(TARGET_OUT_SHARED_LIBRARIES)/StreamingServerModules
DARWIN_INSTALLED_ETC_DIR := $(TARGET_OUT_ETC)/streaming
DARWIN_INSTALLED_MEDIA_DIR := $(TARGET_OUT)/media/streaming

.PHONY: all-darwin-targets darwin-sample-targets darwin-config-targets \
  darwin-module-targets darwin-executable-targets darwin-mandatory-targets
all-darwin-targets: darwin-sample-targets darwin-config-targets \
  darwin-module-targets darwin-executable-targets

# $(1): source file path
# $(2): LOCAL_MODULE, default $(basename $(1)).
# $(3): LOCAL_MODULE_PATH, default $(DARWIN_INSTALLED_ETC_DIR).
# $(4): LOCAL_MODULE_CLASS, default ETC.
# $(5): LOCAL_MODULE_TAGS, default optional.
define darwin-include-prebuilt-to-module-path
include $$(CLEAR_VARS)
LOCAL_MODULE := $(if $(strip $(2)),$(2),$(basename $(1)))
LOCAL_MODULE_PATH := $(if $(strip $(3)),$(3),$(DARWIN_INSTALLED_ETC_DIR))
LOCAL_MODULE_CLASS := $(if $(strip $(4)),$(4),ETC)
LOCAL_MODULE_TAGS := $(if $(strip $(5)),$(5),optional)
LOCAL_SRC_FILES := $(1)
include $$(BUILD_PREBUILT)
endef

define darwin-add-prebilt-file-to-module-path
$(eval $(darwin-include-prebuilt-to-module-path))
endef

# $(1): pairs
# $(2): LOCAL_MODULE_PATH, default $(DARWIN_INSTALLED_ETC_DIR).
# $(3): LOCAL_MODULE_CLASS, default ETC.
# $(4): LOCAL_MODULE_TAGS, default optional.
define darwin-add-prebilt-files-to-module-path
$(foreach pair,$(1), \
  $(eval _src := $(call word-colon,1,$(pair))) \
  $(eval _dst := $(call word-colon,2,$(pair))) \
  $(call darwin-add-prebilt-file-to-module-path, \
    $(_src),$(_dst),$(2),$(3),$(4)) \
)
endef

define darwin-add-to-targets
$(foreach t,$(2),$(eval darwin-$(strip $(t))-targets: $(1)))
endef

#
# Main executable for Darwin Streaming Server.
#
include $(CLEAR_VARS)
LOCAL_MODULE := DarwinStreamingServer
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    QTFileLib \
    OSMemoryLib \
    RTSPClientLib \
    APIModules \
    APICommonCode \
    APIModules/OSMemory_Modules \
    APIModules/QTSSAccessLogModule \
    APIModules/QTSSFileModule \
    APIModules/QTSSFlowControlModule \
    APIModules/QTSSReflectorModule \
    APIModules/QTSSSvrControlModule \
    APIModules/QTSSWebDebugModule \
    APIModules/QTSSWebStatsModule \
    APIModules/QTSSAuthorizeModule \
    APIModules/QTSSPOSIXFileSysModule \
    APIModules/QTSSAdminModule \
    APIModules/QTSSMP3StreamingModule \
    APIModules/QTSSRTPFileModule \
    APIModules/QTSSAccessModule \
    APIModules/QTSSHttpFileModule \
    QTFileTools/RTPFileGen.tproj \
    APIStubLib \
    CommonUtilitiesLib \
    RTCPUtilitiesLib \
    HTTPUtilitiesLib \
    RTPMetaInfoLib \
    PrefsSourceLib \
    Server.tproj \
  ) \
  $(empty)

LOCAL_CPPFLAGS := \
  -DDSS_USE_API_CALLBACKS \
  -Wno-format-y2k \
  -include PlatformHeader.h \
  $(empty)

LOCAL_SRC_FILES := \
  CommonUtilitiesLib/daemon.c \
  Server.tproj/GenerateXMLPrefs.cpp \
  Server.tproj/main.cpp \
  Server.tproj/QTSSCallbacks.cpp \
  Server.tproj/QTSSDataConverter.cpp \
  Server.tproj/QTSSDictionary.cpp \
  Server.tproj/QTSSErrorLogModule.cpp \
  Server.tproj/QTSServer.cpp \
  Server.tproj/QTSServerInterface.cpp \
  Server.tproj/QTSServerPrefs.cpp \
  Server.tproj/QTSSExpirationDate.cpp \
  Server.tproj/QTSSFile.cpp \
  Server.tproj/QTSSMessages.cpp \
  Server.tproj/QTSSModule.cpp \
  Server.tproj/QTSSPrefs.cpp \
  Server.tproj/QTSSSocket.cpp \
  Server.tproj/QTSSUserProfile.cpp \
  Server.tproj/RTCPTask.cpp \
  Server.tproj/RTPBandwidthTracker.cpp \
  Server.tproj/RTPOverbufferWindow.cpp \
  Server.tproj/RTPPacketResender.cpp \
  Server.tproj/RTPSession3GPP.cpp \
  Server.tproj/RTPSession.cpp \
  Server.tproj/RTPSessionInterface.cpp \
  Server.tproj/RTPStream3gpp.cpp \
  Server.tproj/RTPStream.cpp \
  Server.tproj/RTSPProtocol.cpp \
  Server.tproj/RTSPRequest3GPP.cpp \
  Server.tproj/RTSPRequest.cpp \
  Server.tproj/RTSPRequestInterface.cpp \
  Server.tproj/RTSPRequestStream.cpp \
  Server.tproj/RTSPResponseStream.cpp \
  Server.tproj/RTSPSession3GPP.cpp \
  Server.tproj/RTSPSession.cpp \
  Server.tproj/RTSPSessionInterface.cpp \
  Server.tproj/RunServer.cpp \
  PrefsSourceLib/FilePrefsSource.cpp \
  PrefsSourceLib/XMLPrefsParser.cpp \
  PrefsSourceLib/XMLParser.cpp \
  OSMemoryLib/OSMemory.cpp \
  RTSPClientLib/RTSPClient.cpp \
  RTSPClientLib/ClientSocket.cpp \
  HTTPUtilitiesLib/HTTPProtocol.cpp \
  HTTPUtilitiesLib/HTTPRequest.cpp \
  RTCPUtilitiesLib/RTCPAckPacket.cpp \
  RTCPUtilitiesLib/RTCPAPPNADUPacket.cpp \
  RTCPUtilitiesLib/RTCPAPPPacket.cpp \
  RTCPUtilitiesLib/RTCPAPPQTSSPacket.cpp \
  RTCPUtilitiesLib/RTCPPacket.cpp \
  RTCPUtilitiesLib/RTCPSRPacket.cpp \
  RTPMetaInfoLib/RTPMetaInfoPacket.cpp \
  APIStubLib/QTSS_Private.cpp \
  APICommonCode/QTSSModuleUtils.cpp \
  APICommonCode/QTSSRollingLog.cpp \
  APICommonCode/SDPSourceInfo.cpp \
  APICommonCode/SourceInfo.cpp \
  APICommonCode/QTAccessFile.cpp \
  APICommonCode/QTSS3GPPModuleUtils.cpp \
  SafeStdLib/InternalStdLib.cpp \
  APIModules/QTSSAccessLogModule/QTSSAccessLogModule.cpp \
  APIModules/QTSSFileModule/QTSSFileModule.cpp \
  APIModules/QTSSFlowControlModule/QTSSFlowControlModule.cpp \
  APIModules/QTSSReflectorModule/QTSSReflectorModule.cpp \
  APIModules/QTSSReflectorModule/QTSSRelayModule.cpp \
  APIModules/QTSSReflectorModule/ReflectorSession.cpp \
  APIModules/QTSSReflectorModule/RelaySession.cpp \
  APIModules/QTSSReflectorModule/ReflectorStream.cpp \
  APIModules/QTSSReflectorModule/RCFSourceInfo.cpp \
  APIModules/QTSSReflectorModule/RTSPSourceInfo.cpp \
  APIModules/QTSSReflectorModule/RelayOutput.cpp \
  APIModules/QTSSReflectorModule/RelaySDPSourceInfo.cpp \
  APIModules/QTSSReflectorModule/RTPSessionOutput.cpp \
  APIModules/QTSSReflectorModule/SequenceNumberMap.cpp \
  APIModules/QTSSWebDebugModule/QTSSWebDebugModule.cpp \
  APIModules/QTSSWebStatsModule/QTSSWebStatsModule.cpp \
  APIModules/QTSSPOSIXFileSysModule/QTSSPosixFileSysModule.cpp \
  APIModules/QTSSAdminModule/AdminElementNode.cpp \
  APIModules/QTSSAdminModule/AdminQuery.cpp \
  APIModules/QTSSAdminModule/QTSSAdminModule.cpp \
  APIModules/QTSSMP3StreamingModule/QTSSMP3StreamingModule.cpp \
  APIModules/QTSSRTPFileModule/QTSSRTPFileModule.cpp \
  APIModules/QTSSRTPFileModule/RTPFileSession.cpp \
  APIModules/QTSSAccessModule/QTSSAccessModule.cpp \
  APIModules/QTSSHttpFileModule/QTSSHttpFileModule.cpp \
  APIModules/QTSSAccessModule/AccessChecker.cpp \
  $(empty)

LOCAL_STATIC_LIBRARIES := \
  darwin-CommonUtilitiesLib \
  darwin-QTFileLib \
  $(empty)

LOCAL_LDFLAGS := -ldl

include $(BUILD_EXECUTABLE)

$(LOCAL_INSTALLED_MODULE): darwin-config-targets darwin-module-targets
$(call darwin-add-to-targets,$(LOCAL_MODULE),executable mandatory)

ifneq ($(strip $(BOARD_HAVE_NO_DARWIN_STREAMINGSERVER_XML)),)
#
# Configuration files.
#
files := \
  streamingserver.xml-ANDROID:streamingserver.xml \
  $(empty)
$(call darwin-add-prebilt-files-to-module-path,$(files))

$(call darwin-add-to-targets, \
  $(foreach f,$(files),$(call word-colon,2,$(f))),config)
endif

#
# Sample media files.
#
samples := \
  sample_100kbit.mov \
  sample_300kbit.mov \
  sample_100kbit.mp4 \
  sample_300kbit.mp4 \
  sample.mp3 \
  sample_50kbit.3gp \
  sample_h264_100kbit.mp4 \
  sample_h264_1mbit.mp4 \
  sample_h264_300kbit.mp4 \
  $(empty)

$(call darwin-add-prebilt-files-to-module-path, \
  $(foreach s,$(samples),$(s):$(s)), \
  $(DARWIN_INSTALLED_MEDIA_DIR), \
  DATA, \
  samples \
)

$(call darwin-add-to-targets,$(samples),sample)

include $(call first-makefiles-under,$(LOCAL_PATH))
