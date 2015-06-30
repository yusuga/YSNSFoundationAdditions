//
//  NSArray+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/02/03.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSArray+YSNSFoundationAdditions.h"

@implementation NSArray (YSNSFoundationAdditions)

- (NSArray *)ys_map:(id (^)(id obj, NSUInteger idx))block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for (int i = 0; i < [self count]; i++) {
        id value = block([self objectAtIndex:i], i);
        if (value) {
            [array addObject:value];
        }
    };    
    return [NSArray arrayWithArray:array];
}

- (id)ys_randomObject
{
    if ([self count] == 0) return nil;
    
    NSUInteger idx = [self count] > UINT32_MAX ? arc4random_uniform(UINT32_MAX) : arc4random_uniform((u_int32_t)[self count]);
    return self[idx];
}

@end
