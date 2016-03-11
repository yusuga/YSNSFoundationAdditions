//
//  NSString+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/03/05.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YSNSFoundationAdditions)

- (BOOL)ys_isDigitsOnly;

/* XML */
- (NSString *)ys_escapedXMLString;
- (NSString *)ys_unescapedXMLString;

/* URL */
- (NSString*)ys_escapedURLString;
- (NSString*)ys_unescapedURLString;

/* Transform */
- (NSString *)ys_transformToHalfwidth;

/* Regular Expression */
- (NSArray<NSTextCheckingResult *> *)ys_findHTTPURIRFC3986Matches;
- (NSArray<NSValue *> *)ys_findTweetURLRanges;
- (NSArray<NSValue *> *)ys_findTwitterHashtagRanges;
- (NSArray<NSValue *> *)ys_findTwitterMentionRanges;

/* Format */
+ (NSString *)clockFormattedStringFromTime:(NSTimeInterval)time;

@end
