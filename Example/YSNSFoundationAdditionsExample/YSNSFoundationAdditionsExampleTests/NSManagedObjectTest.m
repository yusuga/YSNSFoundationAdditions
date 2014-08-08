//
//  NSManagedObjectTest.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2014/08/08.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSManagedObject+YSNSFoundationAdditions.h"
#import "Tweet.h"

@interface NSManagedObjectTest : XCTestCase

@end

@implementation NSManagedObjectTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEntityName
{
    XCTAssertEqualObjects(@"Tweet", [Tweet ys_entityName], @"entityName: %@", [Tweet ys_entityName]);    
}

@end
