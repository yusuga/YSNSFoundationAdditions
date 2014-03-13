//
//  NSObject+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YSNSFoundationAdditions)

- (void)ys_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (void)ys_cancelPreviousPerformBlockWithBlock:(id)block;

@end
