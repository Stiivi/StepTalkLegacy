#
#  GDL2 module
#
#  Copyright (C) 2002 Stefan Urbanek
#
#  Author: Stefan Urbanek
#  Date: 2002 Nov 29
#
#  This file is part of the StepTalk.
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
#  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02111, USA.
#

include $(GNUSTEP_MAKEFILES)/common.make

BUNDLE_NAME = GDL2
    
GDL2_OBJC_FILES = \
        STGDL2Module.m \
        GDL2Constants.m  
        
GDL2_PRINCIPAL_CLASS = STGDL2Module
        
GDL2_RESOURCE_FILES = ScriptingInfo.plist

GDL2_BUNDLE_LIBS += -lgnustep-db2 -lgnustep-db2control -lgnustep-db2modeler

ADDITIONAL_BUNDLE_LIBS = -lStepTalk
ADDITIONAL_INCLUDE_DIRS += -I../../Frameworks/
ADDITIONAL_LIB_DIRS += -L../../Frameworks/StepTalk/StepTalk.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)

BUNDLE_INSTALL_DIR:=$(GNUSTEP_INSTALLATION_DIR)/Library/StepTalk/Modules

ADDITIONAL_OBJCFLAGS = -Wall -Wno-import

# Include gdl2.make IF there
-include $(GNUSTEP_MAKEFILES)/Auxiliary/gdl2.make

# If gdl2.make was included, compile the bundle; else, do nothing
ifneq ($(GDL2_VERSION),)
 include $(GNUSTEP_MAKEFILES)/bundle.make
else
 include $(GNUSTEP_MAKEFILES)/rules.make
endif


GDL2Constants.m : GDL2Constants.list

%.m : %.list
	    @( echo Creating $@ ...; \
	        cat header.m  | sed "s/@@NAME@@/`basename $< .list`/g" > $@;  \
	        cat $< | awk -f create_constants.awk >> $@;\
	        cat footer.m >> $@; )

