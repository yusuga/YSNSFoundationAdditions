//
//  NSArray+YSUIKitAdditions.h
//  YSUIKitAdditionsExample
//
//  Created by Yu Sugawara on 2014/02/03.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YSUIKitAdditions)

- (NSArray *)ys_map:(id (^)(id obj, NSUInteger idx))block;

@end
