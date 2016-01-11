//
//  NSString+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/05.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSString+YSNSFoundationAdditions.h"
#import "NSMutableString+YSNSFoundationAdditions.h"

static NSString * const kAllowedScreenNameCharacters = @"a-zA-Z0-9_";

@implementation NSString (YSNSFoundationAdditions)

/* http://stackoverflow.com/questions/6091414/finding-out-whether-a-string-is-numeric-or-not/6091456#6091456 */

- (BOOL)ys_isDigitsOnly
{
    static NSCharacterSet *s_notDigits;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    });
    return self.length && [self rangeOfCharacterFromSet:s_notDigits].location == NSNotFound;
}

#pragma mark - XML

- (NSString *)ys_escapedXMLString
{
    return [[self.mutableCopy ys_escapeXML] copy];
}


- (NSString *)ys_unescapedXMLString
{
    return [[self.mutableCopy ys_unescapeXML] copy];
}

#pragma mark - URL

- (NSString*)ys_escapedURLString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]._-",
                                                                                 kCFStringEncodingUTF8));
}

- (NSString*)ys_unescapedURLString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 kCFStringEncodingUTF8));
}

#pragma mark - Regular Expression

/**
 *  文字列中に含まれているRFC-3986に準拠しているhttpまたhttpsのURIをすべて探す。
 *
 *  # RFC-3986 URI component:  URI
 *  http://jmrware.com/articles/2009/uri_regexp/URI_regex.html
 *
 *  # Changes
 *  - scheme: [A-Za-z][A-Za-z0-9+\-.]* -> https?
 *  - reg-name: (?:[A-Za-z0-9\-._~!$&'()*+,;=]|%[0-9A-Fa-f]{2})* -> (?:[A-Za-z0-9\-._~!$&'()*+,;=]|%[0-9A-Fa-f]{2})+
 */
- (NSArray<NSTextCheckingResult *> *)ys_findHTTPURIRFC3986Matches
{
    NSString *HTTPURIRFC3986Pattern = @"(https?):(?://(?:(?:[A-Za-z0-9\\-._~!$&'()*+,;=:]|%[0-9A-Fa-f]{2})*@)?(?:\\[(?:(?:(?:(?:[0-9A-Fa-f]{1,4}:){6}|::(?:[0-9A-Fa-f]{1,4}:){5}|(?:[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){4}|(?:(?:[0-9A-Fa-f]{1,4}:){0,1}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){3}|(?:(?:[0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){2}|(?:(?:[0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})?::[0-9A-Fa-f]{1,4}:|(?:(?:[0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})?::)(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))|(?:(?:[0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})?::[0-9A-Fa-f]{1,4}|(?:(?:[0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})?::)|[Vv][0-9A-Fa-f]+\\.[A-Za-z0-9\\-._~!$&'()*+,;=:]+)\\]|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[A-Za-z0-9\\-._~!$&'()*+,;=]|%[0-9A-Fa-f]{2})+)(?::[0-9]*)?(?:/(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)(?:\\?(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@/?]|%[0-9A-Fa-f]{2})*)?(?:\\#(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@/?]|%[0-9A-Fa-f]{2})*)?";
    
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:HTTPURIRFC3986Pattern options:NSRegularExpressionCaseInsensitive error:NULL];
    return [regexp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
}

/**
 *  文字列中に含まれているツイートのURLをすべて探す。
 *
 *  # 引用ツイートの仕様
 *  - `mobile.twitter.com`も有効
 *  - `http`も有効
 *
 *  # Example
 *  https://twitter.com/jack/status/20
 *  https://mobile.twitter.com/jack/status/20
 */
- (NSArray<NSValue *> *)ys_findTweetURLRanges
{
    NSString *pattern = [NSString stringWithFormat:@"https?://(?:mobile.|)twitter.com/[%@]+/status/[0-9]+", kAllowedScreenNameCharacters];
    return [self ys_findRangesWithRegularExpressionPattern:pattern
                                          resultRangeIndex:0];
}

/**
 *  文字列中に含まれているTwitterのハッシュタグをすべて探す。
 *
 *  全ての日本語、アルファベットが利用可能です。ただし、記号、句読点、スペース等は使えません。使えない文字を入れると、そこでハッシュタグが切れてしまいますので注意しましょう。
 *  https://support.twitter.com/articles/20170159-#hashtext
 *
 *  # Undocumented
 *  - `#`は全角も許容されている。
 */
- (NSArray<NSValue *> *)ys_findTwitterHashtagRanges
{
    return [self ys_findRangesWithRegularExpressionPattern:@"(?:^|[\\W]{1})([#＃]{1}[\\w]+)"
                                          resultRangeIndex:1];
}

/**
 *  文字列中に含まれているTwitterのメンションをすべて探す。
 *
 *  ユーザー名は15文字までです。本名は20文字までですが、ユーザー名は使いやすいように短くなっています。
 *  ユーザー名には英数字 (文字のA～Z、数字の0～9) しか含めることはできません。ただし、上記のとおりアンダーラインは例外です。希望するユーザー名に、記号やダッシュ、スペースが含まれていないことを確認してください。
 *  https://support.twitter.com/articles/243961#error
 *
 *  # Undocumented
 *  - `@`は全角も許容されている。
 */
- (NSArray<NSValue *> *)ys_findTwitterMentionRanges
{
    return [self ys_findRangesWithRegularExpressionPattern:[NSString stringWithFormat:@"(?:^|[\\W]{1})([@＠]{1}[%@]{1,15})(?:$|[^%@])+", kAllowedScreenNameCharacters, kAllowedScreenNameCharacters]
                                          resultRangeIndex:1];
}

#pragma mark - Regular Expression - Private

- (NSArray<NSValue *> *)ys_findRangesWithRegularExpressionPattern:(NSString *)pattern
                                                 resultRangeIndex:(NSUInteger)resultRangeIndex
{
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
    NSArray<NSTextCheckingResult *> *matches = [regexp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    if (![matches count]) return nil;
    
    NSMutableArray *ranges = [NSMutableArray arrayWithCapacity:[matches count]];
    for (NSTextCheckingResult *match in matches) {
        NSAssert(resultRangeIndex < [match numberOfRanges], @"resultRangeIndex: %zd, match.numberOfRanges: %zd", resultRangeIndex, [match numberOfRanges]);
        if (resultRangeIndex < [match numberOfRanges]) {
            [ranges addObject:[NSValue valueWithRange:[match rangeAtIndex:resultRangeIndex]]];
        }
    }
    
    return [ranges copy];
}

#pragma mark - Format

+ (NSString *)clockFormattedStringFromTime:(NSTimeInterval)time
{
    if (time < 0.) {
        time = 0.;
    }
    
    if (time < 3600.) {
        return [NSString stringWithFormat:@"%li:%02li",
                lround(floor(time / 60.)) % 60,
                lround(floor(time)) % 60];
    } else {
        return [NSString stringWithFormat:@"%li:%02li:%02li",
                lround(floor(time / 3600.)) % 100,
                lround(floor(time / 60.)) % 60,
                lround(floor(time)) % 60];
    }
}

@end
