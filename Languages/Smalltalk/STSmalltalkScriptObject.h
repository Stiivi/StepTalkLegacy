/**
    STSmalltalkScriptObject.h
    Object that represents script 
 
    Copyright (c) 2002 Free Software Foundation
 
    This file is part of the StepTalk project.
 
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 */

#import <Foundation/NSObject.h>

@class NSMutableArray;
@class NSMutableDictionary;
@class STBytecodeInterpreter;
@class STCompiledScript;
@class STEnvironment;

@interface STSmalltalkScriptObject:NSObject
{
    NSString              *name;
    STBytecodeInterpreter *interpreter;
    STEnvironment         *environment;
    STCompiledScript      *script;
    NSMutableDictionary   *variables;
}
- initWithEnvironment:(STEnvironment *)env
       compiledScript:(STCompiledScript *)compiledScript;
       
@end
