//
//  NSManagedObject+YSNSFoundationAdditions.h
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/08/08.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

@import CoreData;

@interface NSManagedObject (YSNSFoundationAdditions)

+ (NSString*)ys_entityName;
- (NSString*)ys_entityName;

@end
