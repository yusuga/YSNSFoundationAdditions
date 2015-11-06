//
//  NSMutableAttributedString+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2015/11/06.
//  Copyright © 2015年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (YSNSFoundationAdditions)

- (void)ys_escapeXML;
- (void)ys_unescapeXML;

@end
