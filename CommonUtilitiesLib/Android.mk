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
LOCAL_MODULE := darwin-CommonUtilitiesLib
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
  $(addprefix $(DARWIN_TOPSRCDIR)/, \
    CommonUtilitiesLib \
    APIStubLib \
    RTPMetaInfoLib \
    APICommonCode \
  ) \
  $(empty)

LOCAL_CPPFLAGS := \
  -include PlatformHeader.h \
  $(empty)

LOCAL_SRC_FILES := \
  $(addprefix CommonUtilitiesLib/, \
    base64.c \
    GetWord.c \
    Trim.c \
    md5.c \
    atomic.cpp \
    ConfParser.cpp \
    DateTranslator.cpp \
    EventContext.cpp \
    IdleTask.cpp \
    MyAssert.cpp \
    OS.cpp \
    OSCodeFragment.cpp \
    OSCond.cpp \
    OSFileSource.cpp \
    OSHeap.cpp \
    OSBufferPool.cpp \
    OSMutex.cpp \
    OSMutexRW.cpp \
    OSQueue.cpp \
    OSRef.cpp \
    OSThread.cpp \
    Socket.cpp \
    SocketUtils.cpp \
    ResizeableStringFormatter.cpp \
    StringFormatter.cpp \
    StringParser.cpp \
    StringTranslator.cpp \
    StrPtrLen.cpp \
    Task.cpp \
    TCPListenerSocket.cpp \
    TCPSocket.cpp \
    TimeoutTask.cpp \
    UDPDemuxer.cpp \
    UDPSocket.cpp \
    UDPSocketPool.cpp \
    ev.cpp \
    UserAgentParser.cpp \
    QueryParamList.cpp \
    md5digest.cpp \
    SDPUtils.cpp \
  ) \
  $(empty)

include $(BUILD_STATIC_LIBRARY)
