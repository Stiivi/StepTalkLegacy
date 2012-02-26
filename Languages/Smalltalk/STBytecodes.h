/**
    STBytecodes.h
 
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


/* Bytecode table */
/*
#define STReceiverConstant  0x00
#define STTrueConstant      0x01
#define STFalseConstant     0x02
#define STNilConstant       0x03
*/
#define STPushReceiverBytecode         0x00 /* push self */
#define STPushNilBytecode              0x01 
#define STPushTrueBytecode             0x02
#define STPushFalseBytecode            0x03 
/*                                     0x00 - 0x07 receiver,true,false,nil,
                                                   -1,0,1,2 */
#define STPushRecVarBytecode           0x08 /* recvar index */
#define STPushExternBytecode           0x09 /* extern index */
#define STPushTemporaryBytecode        0x0a /* temp index */
#define STPushLiteralBytecode          0x0b /* lit index */
#define STPopAndStoreRecVarBytecode    0x0c /* recvar index */
#define STPopAndStoreExternBytecode    0x0d /* extern index */
#define STPopAndStoreTempBytecode      0x0e /* temp index */
/*                                     0x0f reserved */
#define STSendSelectorBytecode         0x10 /* lit index, arg count  */
#define STSuperSendSelectorBytecode    0x11 /* lit index, arg count  */
#define STBlockCopyBytecode            0x12
#define STLongJumpBytecode             0x13 /* byte 1, byte 2 */
#define STDupBytecode                  0x14
#define STPopStackBytecode             0x15
#define STReturnBytecode               0x16
#define STReturnBlockBytecode          0x17
/*                                     0x18-0x27 reserved single bytecodes */
/*                                     0x27-0xfe reserved */
#define STBreakpointBytecode           0xff

/*
#define STLongJumpOffset(arg1, arg2) \
            ( (((arg1) & 0xff) << 8) | ((arg2) & 0xff) )
#define STLongJumpFirstByte(offset)\
            ( ((offset) >> 8) & 0xff )
#define STLongJumpSecondByte(offset)\
            ( (offset) & 0xff )
*/
#define STLongJumpBytecodeSize 3

@class NSArray;
@class NSString;

typedef struct
{
    unsigned short code;
    unsigned short arg1;
    unsigned short arg2;
    unsigned pointer;
} STBytecode;

extern NSArray *STBytecodeNames;
extern NSString *STBytecodeName(unsigned short code);
extern NSString *STDissasembleBytecode(STBytecode bytecode);

@interface STBytecodes:NSObject
{
    NSData *bytes;
}
- (STBytecode)fetchNextBytecodeAtPointer:(unsigned *)pointer;
@end



