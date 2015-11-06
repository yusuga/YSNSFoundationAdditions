//
//  NSMutableAttributedString+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2015/11/06.
//  Copyright © 2015年 Yu Sugawara. All rights reserved.
//

#import "NSMutableAttributedString+YSNSFoundationAdditions.h"
#import "NSMutableString+YSNSFoundationAdditions.h"

@implementation NSMutableAttributedString (YSNSFoundationAdditions)

/* http://ja.wikipedia.org/wiki/Extensible_Markup_Language#.E5.AE.9F.E4.BD.93.E5.8F.82.E7.85.A7 */

- (void)ys_escapeXML
{
    [[self mutableString] ys_escapeXML];
}

- (void)ys_unescapeXML
{
    [[self mutableString] ys_unescapeXML];
}

@end
