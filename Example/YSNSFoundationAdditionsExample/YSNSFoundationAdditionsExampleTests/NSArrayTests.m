//
//  NSArrayTests.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 6/30/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+YSNSFoundationAdditions.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRandomObject
{
    XCTAssertNil([@[] ys_randomObject]);
    
    NSArray *arr =  @[@"1", @"2", @"3"];
    XCTAssertNotNil([arr ys_randomObject]);
}

@end
