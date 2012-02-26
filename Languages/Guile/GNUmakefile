#
#  Guile language bundle
#
#  Copyright (C) 2000,2001 Stefan Urbanek
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

BUNDLE_NAME        = Guile
BUNDLE_EXTENSION  := .stlanguage
BUNDLE_INSTALL_DIR:=$(GNUSTEP_INSTALLATION_DIR)/Library/StepTalk/Languages
    
Guile_OBJC_FILES = \
        GuileEngine.m 
        
Guile_PRINCIPAL_CLASS = GuileEngine
        
ADDITIONAL_INCLUDE_DIRS += -I../../Source/Headers
ADDITIONAL_LIBRARIES += -I../../Source/Headers
Guile_BUNDLE_LIBS += -lgstep_guile -lScriptKit $(GUILE_LIBS)

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/bundle.make
-include GNUmakefile.postamble
