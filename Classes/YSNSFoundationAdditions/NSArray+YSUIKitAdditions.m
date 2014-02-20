//
//  NSArray+YSUIKitAdditions.m
//  YSUIKitAdditionsExample
//
//  Created by Yu Sugawara on 2014/02/03.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSArray+YSUIKitAdditions.h"

@implementation NSArray (YSUIKitAdditions)

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

@end
