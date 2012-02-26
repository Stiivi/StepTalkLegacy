/**
    STCompilerUtils.m
    Various compiler utilities.
 
    Copyright (c) 2002 Free Software Foundation
 
    This file is part of StepTalk.
 
 */

#import "STCompiler.h"

#import "STCompilerUtils.h"
#import "STSourceReader.h"

#import <StepTalk/STExterns.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSException.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>

/* 
 * Compiler utilities
 * --------------------------------------------------------------------------
 */

/*
 * STCMethod
 * ---------------------------------------------------------------------------
 */



@implementation STCMethod
+ methodWithPattern:(STCMessage *)patt statements:(STCStatements *)stats
{
    STCMethod *method;
    method = [[STCMethod alloc] initWithPattern:patt statements:stats];
    return AUTORELEASE(method);
}
- initWithPattern:(STCMessage *)patt statements:(STCStatements *)stats
{
    [super init];
    messagePattern = RETAIN(patt);
    statements = RETAIN(stats);
    return self;
}
- (void)dealloc
{
    RELEASE(messagePattern);
    RELEASE(statements);
    [super dealloc];
}
- (STCStatements *)statements
{
    return statements;
}

- (STCMessage *)messagePattern
{
    return messagePattern;
}
@end

/*
 * STCStatements
 * ---------------------------------------------------------------------------
 */
@implementation STCStatements
+ statements
{
    STCStatements *statements = [[STCStatements alloc] init];
    return AUTORELEASE(statements);
}
- (void)setTemporaries:(NSArray *)vars
{
    ASSIGN(variables,vars);
}
- (void)setExpressions:(NSArray *)exprs
{
    ASSIGN(expressions,exprs);
}
- (void)setReturnExpression:(STCExpression *)ret
{
    ASSIGN(retexpr,ret);
}
- (void)dealloc
{
    RELEASE(variables);
    RELEASE(expressions);
    RELEASE(retexpr);
    [super dealloc];
}
- (NSArray *)temporaries
{
    return variables;
}
- (NSArray *)expressions
{
    return expressions;
}
- (STCExpression *)returnExpression
{
    return retexpr;
}
@end

/*
 * STCMessage
 * ---------------------------------------------------------------------------
 */

@implementation STCMessage
+ message
{
    STCMessage *message = [[STCMessage alloc] init];
    return AUTORELEASE(message);    
}
- init
{
    [super init];
    
    selector = [[NSMutableString alloc] init];
    args = [[NSMutableArray alloc] init];

    return self;
}
- (void)dealloc
{
    RELEASE(selector);
    RELEASE(args);
    [super dealloc];
}
-(void) addKeyword:(NSString *)keyword object:object
{
    [selector appendString:keyword];
    if(object!=nil)
        [args addObject:object];
}
- (NSString *)selector
{
    return selector;
}
- (NSArray *)arguments
{
    return args;
}
@end

/*
 * STCExpression
 * ---------------------------------------------------------------------------
 */
@implementation STCExpression:NSObject
+ (STCExpression *) primaryExpressionWithObject:(id)anObject
{
    STCPrimaryExpression *expr;
    expr = [[STCPrimaryExpression alloc] initWithObject:anObject];
    return AUTORELEASE(expr);
}

+ (STCExpression *) messageExpressionWithTarget:(id)anObject
                                        message:(STCMessage *)message
{
    STCMessageExpression *expr;
    expr = [[STCMessageExpression alloc] initWithTarget:anObject
                                                message:message];
    return AUTORELEASE(expr);
}

- (void)dealloc
{
    RELEASE(cascade);
    RELEASE(assignments);
    [super dealloc];
}
- (void)setCascade:(NSArray *)casc
{
    ASSIGN(cascade,casc);
}
- (void)setAssignments:(NSArray *)asgs
{
    ASSIGN(assignments,asgs);
}
- (NSArray *)cascade
{
    return cascade;
}
- (NSArray *)assignments
{
    return assignments;
}
- (BOOL)isPrimary
{
    [self subclassResponsibility:_cmd];
    return NO;
}
- (id) target
{
    [self subclassResponsibility:_cmd];
    return nil;
}
- (STCMessage *)message
{
    [self subclassResponsibility:_cmd];
    return nil;
}
- (id) object
{
    [self subclassResponsibility:_cmd];
    return nil;
}

@end

@implementation STCMessageExpression:STCExpression
- initWithTarget:(id)anObject message:(STCMessage *)aMessage;
{
    [super init];
    
    target = RETAIN(anObject);
    message = RETAIN(aMessage);
    
    return self;
}
- (void)dealloc
{
    RELEASE(target);
    RELEASE(message);
    [super dealloc];
}
- (id) target
{
    return target;
}
- (STCMessage *)message
{
    return message;
}
- (BOOL)isPrimary
{
    return NO;
}
@end

@implementation STCPrimaryExpression:STCExpression
{
    id          object;
}
- (void)dealloc
{
    RELEASE(object);
    [super dealloc];
}
- initWithObject:(id)anObject
{
    [super init];
    object = RETAIN(anObject);
    return self;
}

- (id) object
{
    return object;
}
- (BOOL)isPrimary
{
    return YES;
}
@end

/*
 * STCPrimary
 * ---------------------------------------------------------------------------
 */
@implementation STCPrimary
+ primaryWithVariable:(id) anObject
{
    STCPrimary *primary;
    primary = [STCPrimary alloc];
    [primary initWithType:STCVariablePrimaryType object:anObject];
    return AUTORELEASE(primary);
}
+ primaryWithLiteral:(id) anObject
{
    STCPrimary *primary;
    primary = [STCPrimary alloc];
    [primary initWithType:STCLiteralPrimaryType object:anObject];
    return AUTORELEASE(primary);
}
+ primaryWithBlock:(id) anObject
{
    STCPrimary *primary;
    primary = [STCPrimary alloc];
    [primary initWithType:STCBlockPrimaryType object:anObject];
    return AUTORELEASE(primary);
}
+ primaryWithExpression:(id) anObject
{
    STCPrimary *primary;
    primary = [STCPrimary alloc];
    [primary initWithType:STCExpressionPrimaryType object:anObject];
    return AUTORELEASE(primary);
}
- initWithType:(int)newType object:obj
{
    type = newType;
    object = RETAIN(obj);
    return [super init];
}
- (void)dealloc
{
    RELEASE(object);
    [super dealloc];
}
- (int)type
{
    return type;
}
- object
{
    return object;
}
@end


/*
 * Compiler additions for literals
 * ---------------------------------------------------------------------------
 */

@implementation NSString(STCompilerAdditions)
+ (NSString *) symbolFromString:(NSString *)aString
{
    return [self stringWithString:aString];
}
+ (id) characterFromString:(NSString *)aString
{
    return [self stringWithString:aString];
}
@end

@implementation NSMutableString(STCompilerAdditions)
+ (id) stringFromString:(NSString *)aString
{
    return [self stringWithString:aString];
}
@end

@implementation NSNumber(STCompilerAdditions)
+ (id) intNumberFromString:(NSString *)aString
{
    return [self numberWithInt:[aString intValue]];
}
+ (id) realNumberFromString:(NSString *)aString
{
    return [self numberWithDouble:[aString doubleValue]];
}
@end

@implementation NSMutableArray(STCompilerAdditions)
+ (id) arrayFromArray:(NSArray *)anArray
{
    return [self arrayWithArray:anArray];
}
@end
