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
                                  @"123\r\n",
                                  @""];
    
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

#pragma mark - Transform

- (void)testTransformToHalfwidth
{
    XCTAssertEqualObjects([@"カタカナ" ys_transformToHalfwidth], @"ｶﾀｶﾅ");
    XCTAssertEqualObjects([@"混在コンザイ" ys_transformToHalfwidth], @"混在ｺﾝｻﾞｲ");
    XCTAssertEqualObjects([@"ひらがな" ys_transformToHalfwidth], @"ひらがな");
    XCTAssertEqualObjects([@"漢字" ys_transformToHalfwidth], @"漢字");
    XCTAssertEqualObjects([@"abc" ys_transformToHalfwidth], @"abc");
    XCTAssertEqualObjects([@"ａｂｃ" ys_transformToHalfwidth], @"abc");
}

#pragma mark - Regular Expression

- (void)testFindHTTPURIRFC3986Matches
{
    void (^test)(NSString *source, NSArray<NSValue *> *answerRanges) = ^(NSString *source, NSArray<NSValue *> *answerRanges) {
        NSArray<NSTextCheckingResult *> *matches = [source ys_findHTTPURIRFC3986Matches];
        XCTAssertEqual([matches count], [answerRanges count]);
        
        NSLog(@"source: %@", source);
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull match, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = match.range;
            XCTAssertTrue(NSEqualRanges(range, [answerRanges[idx] rangeValue]), @">%zd: answerRange: %@, resultRange:%@, [%@]", idx, NSStringFromRange([answerRanges[idx] rangeValue]), NSStringFromRange(range), [source substringWithRange:range]);
            NSLog(@">%zd: %@, [%@]", idx, NSStringFromRange(range), [source substringWithRange:range]);
        }];
    };
    
    test(@"", nil);
    test(@"http", nil);
    test(@"http:", nil);
    test(@"http:/", nil);
    test(@"http://", nil);
    
    test(@"http://a", @[[NSValue valueWithRange:NSMakeRange(0, 8)]]);
    
    test(@"http://google.com", @[[NSValue valueWithRange:NSMakeRange(0, 17)]]);
    test(@"HTTP://GOOGLE.COM", @[[NSValue valueWithRange:NSMakeRange(0, 17)]]);
    test(@"abc http://google.com", @[[NSValue valueWithRange:NSMakeRange(4, 17)]]);
    test(@"http://google.com http://apple.com", @[[NSValue valueWithRange:NSMakeRange(0, 17)], [NSValue valueWithRange:NSMakeRange(18, 16)]]);
    
    test(@"Along with our new #Twitterbird, we've also updated our Display Guidelines: https://dev.twitter.com/terms/display-guidelines  ^JC", @[[NSValue valueWithRange:NSMakeRange(76, 48)]]);
    test(@"URL tests. https://google.com  query: https://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwilsdqgisrJAhVDrJQKHSiDBS4QFggoMAA&url=http%3A%2F%2Fwww.apple.com%2Fjp%2F&usg=AFQjCNEru1CMn0qABV7TjifNMEOJSUftNg escaped: https://www.google.co.jp/maps/search/%E6%9D%B1%E4%BA%AC+%E5%85%AC%E5%9C%92/@35.6852483,139.7177802,13z/data=!3m1!4b1", @[[NSValue valueWithRange:NSMakeRange(11, 18)], [NSValue valueWithRange:NSMakeRange(38, 203)], [NSValue valueWithRange:NSMakeRange(251, 116)]]);
}

- (void)testFindTweetURLRanges
{
    void (^test)(NSString *source, NSArray<NSValue *> *answerRanges) = ^(NSString *source, NSArray<NSValue *> *answerRanges) {
        NSArray<NSValue *> *ranges = [source ys_findTweetURLRanges];
        XCTAssertEqual([ranges count], [answerRanges count]);
        
        NSLog(@"source: %@", source);
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull rangeValue, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [rangeValue rangeValue];
            XCTAssertTrue(NSEqualRanges(range, [answerRanges[idx] rangeValue]), @">%zd: answerRange: %@, resultRange:%@, [%@]", idx, NSStringFromRange([answerRanges[idx] rangeValue]), NSStringFromRange(range), [source substringWithRange:range]);
            NSLog(@">%zd: %@, [%@]", idx, NSStringFromRange(range), [source substringWithRange:range]);
        }];
    };
    
    void (^testStandardCase)(NSString *source, NSString *tweetURLStr, NSUInteger answerLocation) = ^(NSString *source, NSString *tweetURLStr, NSUInteger answerLocation) {
        test(source, @[[NSValue valueWithRange:NSMakeRange(answerLocation, tweetURLStr.length)]]);
    };
    
    test(@"", nil);
    test(@"https://twitter.com/jack/list/20", nil);
    
    for (NSString *URLStr in @[@"https://twitter.com/jack/status/20",
                               @"http://twitter.com/jack/status/20",
                               @"https://mobile.twitter.com/jack/status/20",
                               @"http://mobile.twitter.com/jack/status/20"])
    {
        testStandardCase(URLStr, URLStr, 0);
        testStandardCase([NSString stringWithFormat:@"abc %@", URLStr], URLStr, 4);
        testStandardCase([NSString stringWithFormat:@"%@ 4", URLStr], URLStr, 0);
        testStandardCase([NSString stringWithFormat:@"abc %@ abc", URLStr], URLStr, 4);
    }
    
    test(@"abc https://twitter.com/jack/status/20 abc http://mobile.twitter.com/jack/status/20",
         @[[NSValue valueWithRange:NSMakeRange(4, 34)],
           [NSValue valueWithRange:NSMakeRange(43, 40)]]);
}

- (void)testFindHashttagRanges
{
    NSArray<NSString *> *sources = @[@"#hashtag",
                                     @"#head apple",                                // 先頭
                                     @"apple #end",                                 // 末尾
                                     @"text\n#lineBreaks\ntext",                    // 改行
                                     @"# apple #ingnoreSingelSharp # apple #",      // #のみ
                                     @"##apple",                                    // 連続
                                     @"apple ＃fullWidth apple",                     // 全角#
                                     @"apple #key,word #key-word #key!word,#key",   // 記号
                                     @"http://google.com#abc #ignoreSharpInURL",    // URL
                                     @"#CASEINSENSITIVE apple apple",               // CaseInsensitive
                                     @"apple #日本語 apple",                          // 日本語
                                     @"apple #mix日本語とenglish apple",              // 混合
                                     ];
    NSArray<NSString *> *answers = @[@"#hashtag",
                                     @"#head",
                                     @"#end",
                                     @"#lineBreaks",
                                     @"#ingnoreSingelSharp",
                                     @"#apple",
                                     @"＃fullWidth",
                                     @"#key",
                                     @"#ignoreSharpInURL",
                                     @"#CASEINSENSITIVE",
                                     @"#日本語",
                                     @"#mix日本語とenglish",
                                     ];
    XCTAssertEqual([sources count], [answers count]);
    
    XCTAssertEqual([[@"" ys_findTwitterHashtagRanges] count], 0);
    XCTAssertEqual([[@"a#abc" ys_findTwitterHashtagRanges] count], 0);
    XCTAssertEqual([[@"あ#abc" ys_findTwitterHashtagRanges] count], 0);

    [sources enumerateObjectsUsingBlock:^(NSString * _Nonnull source, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSValue *> *ranges = [source ys_findTwitterHashtagRanges];
        XCTAssertGreaterThan([ranges count], 0, @"{\n\tsource = %@\n}", source);
        
        NSMutableString *result = [NSString stringWithFormat:@"{\n\tsource = %@", source].mutableCopy;
        NSString *answer = answers[idx];
        
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull rangeValue, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [rangeValue rangeValue];
            NSString *matchedText = [source substringWithRange:range];
            XCTAssertEqualObjects(matchedText, answer);
            [result appendFormat:@"\n\trange[%zd] = %@, found = %@", idx, NSStringFromRange(range), matchedText];
        }];
        [result appendString:@"\n}"];
        
        NSLog(@"\n%@", result);
    }];
    
    // ハッシュタグが連続する
    {
        NSString *source = @"#apple #iphone";
        NSArray<NSValue *> *ranges = [source ys_findTwitterHashtagRanges];
        XCTAssertEqual([ranges count], 2);
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull rangeValue, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *hashtag = [source substringWithRange:[rangeValue rangeValue]];
            XCTAssertGreaterThan(hashtag.length, 0);
            
            switch (idx) {
                case 0:
                    XCTAssertEqualObjects(hashtag, @"#apple");
                    break;
                case 1:
                    XCTAssertEqualObjects(hashtag, @"#iphone");
                    break;
                default:
                    abort();
                    break;
            }
        }];
    }
}

- (void)testFindMentionRanges
{
    NSArray<NSString *> *sources = @[@"@mention",
                                     @"@head apple",                                // 先頭
                                     @"apple @end",                                 // 末尾
                                     @"@ apple @ingnoreAtsign @ apple @",           // @のみ
                                     @"@@apple",                                    // @が連続
                                     @"apple @key,word @key-word @key!word,@key",   // ignore記号
                                     @"apple @_underscores",                        // _
                                     @"apple @under_scores",                        // _
                                     @"apple @underscores_",                        // _
                                     @"apple @1234",                                // number
                                     @"@CASEINSENSITIVE apple apple",               // CaseInsensitive
                                     @"apple @日本語 @ignoreMultibyte",               // 日本語
                                     @"apple @mix123_abc apple",                    // 混合
                                     ];
    NSArray<NSString *> *answers = @[@"@mention",
                                     @"@head",
                                     @"@end",
                                     @"@ingnoreAtsign",
                                     @"@apple",
                                     @"@key",
                                     @"@_underscores",
                                     @"@under_scores",
                                     @"@underscores_",
                                     @"@1234",
                                     @"@CASEINSENSITIVE",
                                     @"@ignoreMultibyte",
                                     @"@mix123_abc",
                                     ];
    XCTAssertEqual([sources count], [answers count]);
    
    XCTAssertEqual([[@"" ys_findTwitterMentionRanges] count], 0);
    XCTAssertEqual([[@"abc@abc" ys_findTwitterMentionRanges] count], 0); // @の前にScreenNameに有効な文字がある
    XCTAssertEqual([[@"あ@abc" ys_findTwitterMentionRanges] count], 1); // @の前にScreenNameに無効な文字がある
    
    XCTAssertEqual([[@"@123456789012345" ys_findTwitterMentionRanges] count], 1); // 15文字
    XCTAssertEqual([[@"@1234567890123456" ys_findTwitterMentionRanges] count], 1); // 16文字
    
    [sources enumerateObjectsUsingBlock:^(NSString * _Nonnull source, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSValue *> *ranges = [source ys_findTwitterMentionRanges];
        XCTAssertGreaterThan([ranges count], 0, @"{\n\tsource = %@\n}", source);
        
        NSMutableString *result = [NSString stringWithFormat:@"{\n\tsource = %@", source].mutableCopy;
        NSString *answer = answers[idx];
        
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull rangeValue, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [rangeValue rangeValue];
            NSString *matchedText = [source substringWithRange:range];
            XCTAssertEqualObjects(matchedText, answer);
            [result appendFormat:@"\n\trange[%zd] = %@, found = %@", idx, NSStringFromRange(range), matchedText];
        }];
        [result appendString:@"\n}"];
        
        NSLog(@"\n%@", result);
    }];
    
    // メンションが連続する
    {
        NSString *source = @"@apple @iphone";
        NSArray<NSValue *> *ranges = [source ys_findTwitterMentionRanges];
        XCTAssertEqual([ranges count], 2);
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull rangeValue, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *mention = [source substringWithRange:[rangeValue rangeValue]];
            XCTAssertGreaterThan(mention.length, 0);
            
            switch (idx) {
                case 0:
                    XCTAssertEqualObjects(mention, @"@apple");
                    break;
                case 1:
                    XCTAssertEqualObjects(mention, @"@iphone");
                    break;
                default:
                    abort();
                    break;
            }
        }];
    }
}

#pragma mark - Format

- (void)testClockFormattedString
{
    XCTAssertEqualObjects(@"0:00", [NSString clockFormattedStringFromTime:-1.]);
    XCTAssertEqualObjects(@"0:00", [NSString clockFormattedStringFromTime:0.]);
    XCTAssertEqualObjects(@"0:01", [NSString clockFormattedStringFromTime:1.]);
    XCTAssertEqualObjects(@"0:59", [NSString clockFormattedStringFromTime:59.]);
    XCTAssertEqualObjects(@"1:00", [NSString clockFormattedStringFromTime:60.]);
    XCTAssertEqualObjects(@"1:01", [NSString clockFormattedStringFromTime:61.]);
    XCTAssertEqualObjects(@"9:59", [NSString clockFormattedStringFromTime:599.]);
    XCTAssertEqualObjects(@"10:00", [NSString clockFormattedStringFromTime:600.]);
    XCTAssertEqualObjects(@"10:01", [NSString clockFormattedStringFromTime:601.]);
    XCTAssertEqualObjects(@"59:59", [NSString clockFormattedStringFromTime:3599.]);
    XCTAssertEqualObjects(@"1:00:00", [NSString clockFormattedStringFromTime:3600.]);
    XCTAssertEqualObjects(@"1:00:01", [NSString clockFormattedStringFromTime:3601.]);
    XCTAssertEqualObjects(@"9:59:59", [NSString clockFormattedStringFromTime:35999.]);
    XCTAssertEqualObjects(@"10:00:00", [NSString clockFormattedStringFromTime:36000.]);
    XCTAssertEqualObjects(@"10:00:01", [NSString clockFormattedStringFromTime:36001.]);
}

@end