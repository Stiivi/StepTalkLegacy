/**
   Functions.m
  
   Copyright (c) 2002 Free Software Foundation
  
   Written by: Stefan Urbanek <urbanek@host.sk>
   Date: 2001 Nov 14
 
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


@class NSDictionary;
@class NSString;

#define _STCreateConstantsDictionaryForType(t, v, n, c) \
            _ST_##t##_namesDictionary(v, n, c);
            
#define function_header(type) \
            NSDictionary *_ST_##type##_namesDictionary(type *vals, \
                                                       NSString **names,  \
                                                       int count)

function_header(int);
function_header(float);
function_header(id);

