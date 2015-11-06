//
//  NSObjectTest.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+YSNSFoundationAdditions.h"
#import <NSRunLoop+PerformBlock/NSRunLoop+PerformBlock.h>

@interface NSObjectTest : XCTestCase

@end

@implementation NSObjectTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformBlock
{
    __block BOOL finished;
    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        [self ys_performBlock:^{
            NSLog(@"%s", __func__);
            finished = YES;
            *finish = YES;
        } afterDelay:1.];
    }];
    
    if (!finished) {
        XCTAssert(0, @"Not execute perform block");
    }
}

- (void)testPerformBlocks
{
    __block BOOL finished1, finished2, finished3, finished4;
    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        [self ys_performBlock:^{
            NSLog(@"%s", __func__);
            finished1 = YES;
        } afterDelay:0.2];
        
        [self ys_performBlock:^{
            NSLog(@">%s", __func__);
            finished2 = YES;
        } afterDelay:0.4];
        
        [self ys_performBlock:^{
            NSLog(@">>%s", __func__);
            finished3 = YES;
        } afterDelay:0.6];
        
        [self ys_performBlock:^{
            NSLog(@">>>%s", __func__);
            finished4 = YES;
            *finish = YES;
        } afterDelay:0.8];
    } timeoutInterval:10.];
    
    if (!finished1 || !finished2 || !finished3 || !finished4) {
        XCTAssert(0, @"Not execute perform block");
    }
}

- (void)testPerformBlockCancel
{
    __block BOOL finished1 = NO;
    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        void(^block)(void) = ^{
            NSLog(@"%s", __func__);
            finished1 = YES;
        };
        [self ys_performBlock:block afterDelay:3.];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1.];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self ys_cancelPreviousPerformBlockWithBlock:block];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSThread sleepForTimeInterval:3.];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        *finish = YES;
                    });
                });
            });
        });
    } timeoutInterval:5.];
    
    XCTAssertFalse(finished1, @"Not cancel perform block");
}

- (void)testPerformBlockDefaultCancel
{
    __block BOOL finished1 = NO;
    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        void(^block)(void) = ^{
            NSLog(@"%s", __func__);
            finished1 = YES;
        };
        [self ys_performBlock:block afterDelay:3.];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1.];
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSThread sleepForTimeInterval:3.];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        *finish = YES;
                    });
                });
            });
        });
    } timeoutInterval:5.];
    
    XCTAssertFalse(finished1, @"Not cancel perform block");
}

@end
