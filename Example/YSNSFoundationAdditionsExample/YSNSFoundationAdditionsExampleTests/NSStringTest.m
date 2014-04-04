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

#pragma mark - URL

- (NSString*)URLString
{
    return @"文字列!*'();:@&=+$,/?%#[]._-";
}

- (NSString*)escapedURLString
{
    /* http://www.wap2.jp/cgi/escape/ */
    return @"%E6%96%87%E5%AD%97%E5%88%97%21%2A%27%28%29%3B%3A%40%26%3D%2B%24%2C%2F%3F%25%23%5B%5D%2E%5F%2D";
}

- (void)testEscapeURL
{
    XCTAssertTrue([[[self URLString] ys_escapedURLString] isEqualToString:[self escapedURLString]],
                  @"str1: %@, str2: %@", [[self URLString] ys_escapedURLString], [self escapedURLString]);
    
    XCTAssertFalse([[[self URLString] ys_escapedURLString] isEqualToString:[self URLString]],
                   @"str1: %@, str2: %@", [[self URLString] ys_escapedURLString], [self URLString]);
    
    XCTAssertTrue([[@"" ys_escapedURLString] isEqualToString:@""],
                  @"str1: %@", [@"" ys_escapedURLString]);
}

- (void)testUnescapeURLString
{
    XCTAssertTrue([[self URLString] isEqualToString:[[self escapedURLString] ys_unescapedURLString]],
                  @"str1: %@, str2: %@", [self URLString], [[self escapedURLString] ys_unescapedURLString]);
    
    XCTAssertFalse([[self escapedURLString] isEqualToString:[[self escapedURLString] ys_unescapedURLString]],
                   @"str1: %@, str2: %@", [self escapedURLString], [[self escapedURLString] ys_unescapedURLString]);
    
    XCTAssertTrue([[[@"" ys_escapedURLString] ys_unescapedURLString] isEqualToString:@""],
                  @"str1: %@", [[@"" ys_escapedURLString] ys_unescapedURLString]);
}

@end