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

#pragma mark - XML

- (NSString*)XMLString
{
    return @"& ' \" < >";
}

- (NSString*)escapedXMLString
{
    return @"&amp; &apos; &quot; &lt; &gt;";
}

- (void)testEscapeXMLString
{
    XCTAssertTrue([[[self XMLString] ys_escapedXMLString] isEqualToString:[self escapedXMLString]],
                  @"str1: %@, str2: %@", [[self XMLString] ys_escapedXMLString], [self escapedXMLString]);
    
    XCTAssertFalse([[[self XMLString] ys_escapedXMLString] isEqualToString:[self XMLString]],
                   @"str1: %@, str2: %@", [[self XMLString] ys_escapedXMLString], [self XMLString]);
    
    XCTAssertTrue([[@"" ys_escapedXMLString] isEqualToString:@""],
                  @"str1: %@", [@"" ys_escapedXMLString]);
}

- (void)testUnescapeXMLString
{
    XCTAssertTrue([[self XMLString] isEqualToString:[[self escapedXMLString] ys_unescapedXMLString]],
                  @"str1: %@, str2: %@", [self XMLString], [[self escapedXMLString] ys_unescapedXMLString]);
    
    XCTAssertFalse([[self escapedXMLString] isEqualToString:[[self escapedXMLString] ys_unescapedXMLString]],
                   @"str1: %@, str2: %@", [self escapedXMLString], [[self escapedXMLString] ys_unescapedXMLString]);
    
    XCTAssertTrue([[[@"" ys_escapedXMLString] ys_unescapedXMLString] isEqualToString:@""],
                  @"str1: %@", [[@"" ys_escapedXMLString] ys_unescapedXMLString]);
}

@end
