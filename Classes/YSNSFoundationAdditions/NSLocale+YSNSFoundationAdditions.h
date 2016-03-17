//
//  NSLocale+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2016/03/17.
//  Copyright © 2016年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (YSNSFoundationAdditions)

/**
 *  https://ja.wikipedia.org/wiki/ISO_639-1%E3%82%B3%E3%83%BC%E3%83%89%E4%B8%80%E8%A6%A7
 */
+ (NSArray<NSString *> *)ys_availableISO639_1LocaleIdentifiers;
+ (NSArray<NSString *> *)ys_displayNamesWithLocaleIdentifiers:(NSArray<NSString *> *)localeIDs;

@end
