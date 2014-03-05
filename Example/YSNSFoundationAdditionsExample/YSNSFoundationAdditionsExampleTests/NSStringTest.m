//
//  NSStringTest.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/05.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+YSNSFoundationAdditions.h"

@interface NSStringTest : XCTestCase

@end

@implementation NSStringTest

- (void)testIsDegitsOnly
{
    NSArray *digitsStrings = @[@"1234",
                               @"１２３４",
                               @"12３４",
                               @"１２34"];
    
    for (NSString *str in digitsStrings) {
        XCTAssertTrue([str ys_isDigitsOnly], @"str = %@", str);
    }
    
    NSArray *notDigitsStrings = @[@"123abc",
                                  @"abc123",
                                  @"12a3",
                                  @"12 3",
                                  @"1,234",
                                  @" 123",
                                  @"123 ",
                                  @"　123",
                                  @"123　",
                                  @"123\n",
                                  @"123\r\n"];
    
    for (NSString *str in notDigitsStrings) {
        XCTAssertFalse([str ys_isDigitsOnly], @"str = %@", str);
    }
}

@end
