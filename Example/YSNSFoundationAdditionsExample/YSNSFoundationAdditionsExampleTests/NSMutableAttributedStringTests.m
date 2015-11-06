//
//  NSMutableAttributedStringTests.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2015/11/06.
//  Copyright © 2015年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSMutableAttributedString+YSNSFoundationAdditions.h"

@interface NSMutableAttributedStringTests : XCTestCase

@end

@implementation NSMutableAttributedStringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEscapeXMLString
{
    {
        NSMutableAttributedString *escapedString = [self XMLString];
        [escapedString ys_escapeXML];
        XCTAssertTrue([escapedString isEqualToAttributedString:[self escapedXMLString]],
                      @"str1: %@, str2: %@", escapedString, [self escapedXMLString]);
    }
    {
        NSMutableAttributedString *escapedString = [self XMLString];
        [escapedString ys_escapeXML];
        XCTAssertFalse([escapedString isEqualToAttributedString:[self XMLString]],
                       @"str1: %@, str2: %@", escapedString, [self XMLString]);
    }
    {
        NSMutableAttributedString *escapedString = [[NSMutableAttributedString alloc] initWithString:@""];
        [escapedString ys_escapeXML];
        NSMutableAttributedString *emptyString = [[NSMutableAttributedString alloc] initWithString:@""];
        XCTAssertTrue([escapedString isEqualToAttributedString:emptyString],
                      @"str1: %@", escapedString);
    }
}

- (void)testUnescapeXMLString
{
    {
        NSMutableAttributedString *unescapedString = [self escapedXMLString];
        [unescapedString ys_unescapeXML];
        XCTAssertTrue([[self XMLString] isEqualToAttributedString:unescapedString],
                      @"str1: %@, str2: %@", [self XMLString], unescapedString);
    }
    {
        NSMutableAttributedString *unescapedString = [self escapedXMLString];
        [unescapedString ys_unescapeXML];
        XCTAssertFalse([[self escapedXMLString] isEqualToAttributedString:unescapedString],
                       @"str1: %@, str2: %@", [self escapedXMLString], unescapedString);
    }
    {
        NSMutableAttributedString *unescapedString = [[NSMutableAttributedString alloc] initWithString:@""];
        [unescapedString ys_unescapeXML];
        NSMutableAttributedString *emptyString = [[NSMutableAttributedString alloc] initWithString:@""];
        XCTAssertTrue([unescapedString isEqualToAttributedString:emptyString],
                      @"str1: %@", unescapedString);
    }
}

#pragma mark - Utility

- (NSMutableAttributedString *)XMLString
{
    return [[NSMutableAttributedString alloc] initWithString:@"& ' \" < >"];
}

- (NSMutableAttributedString *)escapedXMLString
{
    return [[NSMutableAttributedString alloc] initWithString:@"&amp; &apos; &quot; &lt; &gt;"];
}

@end
