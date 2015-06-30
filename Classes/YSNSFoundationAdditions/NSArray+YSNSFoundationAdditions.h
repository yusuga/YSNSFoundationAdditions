//
//  NSArray+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/02/03.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YSNSFoundationAdditions)

- (NSArray *)ys_map:(id (^)(id obj, NSUInteger idx))block;

- (id)ys_randomObject;

@end
