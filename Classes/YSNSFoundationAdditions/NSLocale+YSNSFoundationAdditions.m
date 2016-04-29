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

+ (BOOL)ys_isRightToLeftLanguage:(NSString *)ISO639_1Code
{
    if (!ISO639_1Code) return NO;
    else if ([ISO639_1Code isEqualToString:@"ar"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"arc"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"bcc"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"bqi"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"ckb"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"dv"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"fa"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"glk"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"he"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"lrc"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"mzn"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"pnb"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"ps"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"sd"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"ug"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"ur"]) return YES;
    else if ([ISO639_1Code isEqualToString:@"yi"]) return YES;
    
    return  NO;}

@end
