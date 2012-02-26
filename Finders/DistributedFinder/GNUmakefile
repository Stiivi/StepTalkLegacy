#
#  Distributed Objects Finder module
#
#  Copyright (C)2002 Stefan Urbanek
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

BUNDLE_NAME = DistributedFinder
    
DistributedFinder_OBJC_FILES = STDistributedFinder.m

DistributedFinder_PRINCIPAL_CLASS = STDistributedFinder
        

DistributedFinder_BUNDLE_LIBS += -lStepTalk

ADDITIONAL_BUNDLE_LIBS = -lStepTalk
ADDITIONAL_INCLUDE_DIRS += -I../../Frameworks/
ADDITIONAL_LIB_DIRS += -L../../Frameworks/StepTalk/StepTalk.framework/Versions/Current/$(GNUSTEP_TARGET_LDIR)

BUNDLE_INSTALL_DIR:=$(GNUSTEP_INSTALLATION_DIR)/Library/StepTalk/Finders

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/bundle.make
-include GNUMakefile.postamble
