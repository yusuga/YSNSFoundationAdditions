//
//  NSObject+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSObject+YSNSFoundationAdditions.h"

@implementation NSObject (YSNSFoundationAdditions)

- (void)ys_executeBlock:(void (^)(void))block
{
	block();
}

- (void)ys_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	[self performSelector:@selector(ys_executeBlock:)
			   withObject:[block copy]
			   afterDelay:delay];
}

- (void)ys_cancelPreviousPerformBlockWithBlock:(id)block
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(ys_executeBlock:) object:block];
}

//+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget selector:(SEL)aSelector object:(id)anArgument

@end
