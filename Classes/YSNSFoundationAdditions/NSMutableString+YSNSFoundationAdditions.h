//
//  NSMutableString+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/04/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (YSNSFoundationAdditions)

- (NSMutableString *)ys_escapeXML;
- (NSMutableString *)ys_unescapeXML;

@end
