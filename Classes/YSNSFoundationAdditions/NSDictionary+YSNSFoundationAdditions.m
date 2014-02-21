//
//  NSDictionary+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/02/21.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSDictionary+YSNSFoundationAdditions.h"

@implementation NSDictionary (YSNSFoundationAdditions)

- (id)ys_objectOrNilForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if (obj == [NSNull null]) {
        return nil;
    } else {
        return obj;
    }
}

@end
