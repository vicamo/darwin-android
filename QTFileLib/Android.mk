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

common_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    QTFileLib \
    RTPMetaInfoLib \
    OSMemoryLib \
    APIStubLib \
    CommonUtilitiesLib \
  ) \
  $(empty)

common_CPPFLAGS := \
  -include PlatformHeader.h \
  $(empty)

common_SRC_FILES := \
  $(addprefix QTFileLib/, \
    QTAtom.cpp \
    QTAtom_dref.cpp \
    QTAtom_elst.cpp \
    QTAtom_hinf.cpp \
    QTAtom_mdhd.cpp \
    QTAtom_mvhd.cpp \
    QTAtom_stco.cpp \
    QTAtom_stsc.cpp \
    QTAtom_stsd.cpp \
    QTAtom_stss.cpp \
    QTAtom_stsz.cpp \
    QTAtom_stts.cpp \
    QTAtom_tkhd.cpp \
    QTAtom_tref.cpp \
    QTFile.cpp \
    QTFile_FileControlBlock.cpp \
    QTHintTrack.cpp \
    QTRTPFile.cpp \
    QTTrack.cpp \
  ) \
  SafeStdLib/InternalStdLib.cpp \
  $(empty)

include $(CLEAR_VARS)
LOCAL_MODULE := darwin-QTFileLib
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_C_INCLUDES := $(common_C_INCLUDES)
LOCAL_CPPFLAGS := \
  $(common_CPPFLAGS) \
  -DDSS_USE_API_CALLBACKS \
  $(empty)
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := darwin-QTFileExternalLib
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_C_INCLUDES := $(common_C_INCLUDES)
LOCAL_CPPFLAGS := $(common_CPPFLAGS)
include $(BUILD_STATIC_LIBRARY)
