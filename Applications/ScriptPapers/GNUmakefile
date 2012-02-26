#  Script Papers
#
#  Copyright (C) 2002 Stefan Urbanek
#
#  Written by:	Stefan Urbanek
#  Date: 2003 Apr 26
#
#  This file is part of the AgentFarms
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Library General Public
#  License as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
#  Library General Public License for more details.
#
#  You should have received a copy of the GNU Library General Public
#  License along with this library; if not, write to the Free
#  Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA
#

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME     = ScriptPapers
PACKAGE_NAME = ScriptPapers

ScriptPapers_APPLICATION_ICON =
ScriptPapers_MAIN_MODEL_FILE  = ScriptPapers.gorm

ADDITIONAL_GUI_LIBS += -lStepTalk

############################################################################
# ObjC files

ScriptPapers_OBJC_FILES= \
        AppController.m \
        ScriptPaper.m \
        ScriptPaperController.m \
        NSObject+NibLoading.m \
        NSTextView+additions.m \
        main.m 

############################################################################
# Resource files

ScriptPapers_LOCALIZED_RESOURCE_FILES= \
        ScriptPapers.gorm  \
        Paper.gorm

ScriptPapers_RESOURCE_FILES= \
        Images/ScriptPaperFile.tiff  \
        Images/ScriptPapers.tiff
        
ADDITIONAL_OBJCFLAGS = -Wno-import

############################################################################

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
