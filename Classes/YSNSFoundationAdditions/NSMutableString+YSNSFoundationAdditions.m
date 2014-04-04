//
//  NSMutableString+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/04/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "NSMutableString+YSNSFoundationAdditions.h"

@implementation NSMutableString (YSNSFoundationAdditions)

/* http://ja.wikipedia.org/wiki/Extensible_Markup_Language#.E5.AE.9F.E4.BD.93.E5.8F.82.E7.85.A7 */

- (NSMutableString *)ys_escapeXML
{
    [self replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"'"  withString:@"&apos;" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    return self;
}

- (NSMutableString *)ys_unescapeXML
{
    [self replaceOccurrencesOfString:@"&amp;"  withString:@"&"  options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&apos;" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&gt;"   withString:@">"  options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&lt;"   withString:@"<"  options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    return self;
}

@end
