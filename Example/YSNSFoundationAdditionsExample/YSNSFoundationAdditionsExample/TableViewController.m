//
//  TableViewController.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2016/03/17.
//  Copyright © 2016年 Yu Sugawara. All rights reserved.
//

#import "TableViewController.h"
#import "NSLocale+YSNSFoundationAdditions.h"

@implementation TableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"%@ %@", NSStringFromSelector(@selector(ys_availableISO639_1LocaleIdentifiers)), [NSLocale ys_availableISO639_1LocaleIdentifiers]);
                    break;
                case 1:
                    NSLog(@"%@ %@", NSStringFromSelector(@selector(ys_displayNamesWithLocaleIdentifiers:)), [NSLocale ys_displayNamesWithLocaleIdentifiers:[NSLocale ys_availableISO639_1LocaleIdentifiers]]);
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

@end
