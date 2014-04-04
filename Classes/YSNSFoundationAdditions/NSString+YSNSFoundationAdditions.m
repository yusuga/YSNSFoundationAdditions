//
//  NSString+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/05.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSString+YSNSFoundationAdditions.h"
#import "NSMutableString+YSNSFoundationAdditions.h"

@implementation NSString (YSNSFoundationAdditions)

/* http://stackoverflow.com/questions/6091414/finding-out-whether-a-string-is-numeric-or-not/6091456#6091456 */

- (BOOL)ys_isDigitsOnly
{
    static NSCharacterSet *s_notDigits;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    });
    return [self rangeOfCharacterFromSet:s_notDigits].location == NSNotFound;
}

#pragma mark - XML

- (NSString *)ys_escapedXMLString
{
    return [self.mutableCopy ys_escapeXML];
}


- (NSString *)ys_unescapedXMLString
{
    return [self.mutableCopy ys_unescapeXML];
}

@end
