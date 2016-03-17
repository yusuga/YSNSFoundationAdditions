//
//  NSLocale+YSNSFoundationAdditions.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2016/03/17.
//  Copyright © 2016年 Yu Sugawara. All rights reserved.
//

#import "NSLocale+YSNSFoundationAdditions.h"

@implementation NSLocale (YSNSFoundationAdditions)

+ (NSArray<NSString *> *)ys_availableISO639_1LocaleIdentifiers
{
    NSMutableArray *localeIDs = [NSMutableArray array];
    for (NSString *localeID in [NSLocale availableLocaleIdentifiers]) {
        if ([localeID rangeOfString:@"_"].location != NSNotFound) continue;
        [localeIDs addObject:localeID];
    }
    return [localeIDs copy];
}

+ (NSArray<NSString *> *)ys_displayNamesWithLocaleIdentifiers:(NSArray<NSString *> *)localeIDs
{
    NSMutableArray *names = [NSMutableArray arrayWithCapacity:[localeIDs count]];
    for (NSString *localeID in localeIDs) {
        [names addObject:[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:localeID]];
    }
    return [names copy];
}

@end
