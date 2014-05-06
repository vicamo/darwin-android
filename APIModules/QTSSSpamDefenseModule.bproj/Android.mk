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
LOCAL_MODULE := QTSSSpamDefenseModule
LOCAL_MODULE_PATH := $(DARWIN_INSTALLED_MODULE_DIR)
LOCAL_MODULE_TAGS := optional

# Here we play a trick to avoid the '.so' suffix.
LOCAL_UNINSTALLABLE_MODULE := true

LOCAL_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    APIModules/QTSSSpamDefenseModule.bproj \
    APICommonCode \
    APIModules/OSMemory_Modules \
    APIStubLib \
    CommonUtilitiesLib \
    RTPMetaInfoLib \
  ) \
  $(empty)

LOCAL_CPPFLAGS := \
  -include PlatformHeader.h \
  $(empty)

LOCAL_SRC_FILES := \
  APIModules/OSMemory_Modules/OSMemory_Modules.cpp \
  APIStubLib/QTSS_Private.cpp \
  APICommonCode/QTSSModuleUtils.cpp \
  APICommonCode/QTSSRollingLog.cpp \
  APICommonCode/SDPSourceInfo.cpp \
  APICommonCode/SourceInfo.cpp \
  RTPMetaInfoLib/RTPMetaInfoPacket.cpp \
  APIModules/QTSSSpamDefenseModule.bproj/QTSSSpamDefenseModule.cpp
  $(empty)

LOCAL_STATIC_LIBRARIES := \
  darwin-CommonUtilitiesLib \
  darwin-QTFileLib \
  $(empty)

LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)

installed_qtss_module := $(LOCAL_MODULE_PATH)/$(LOCAL_MODULE)
$(eval $(call copy-one-file,$(LOCAL_BUILT_MODULE),$(installed_qtss_module)))

$(LOCAL_MODULE): $(installed_qtss_module)

$(call darwin-add-to-targets,$(LOCAL_MODULE),module)
