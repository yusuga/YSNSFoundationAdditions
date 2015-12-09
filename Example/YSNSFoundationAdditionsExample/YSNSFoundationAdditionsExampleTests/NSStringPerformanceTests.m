//
//  NSStringPerformanceTests.m
//  YSNSFoundationAdditionsExample
//
//  Created by Yu Sugawara on 2015/12/08.
//  Copyright © 2015年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+YSNSFoundationAdditions.h"

@interface NSStringPerformanceTests : XCTestCase

@end

@implementation NSStringPerformanceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceHTTPURIRFC3986Matches1
{
    [self measureMetrics:[XCTestCase defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        NSString *source = @"URL tests. https://google.com  query: https://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwilsdqgisrJAhVDrJQKHSiDBS4QFggoMAA&url=http%3A%2F%2Fwww.apple.com%2Fjp%2F&usg=AFQjCNEru1CMn0qABV7TjifNMEOJSUftNg escaped: https://www.google.co.jp/maps/search/%E6%9D%B1%E4%BA%AC+%E5%85%AC%E5%9C%92/@35.6852483,139.7177802,13z/data=!3m1!4b1";
        
        [self startMeasuring];
        [source ys_findHTTPURIRFC3986Matches];
        [self stopMeasuring];
    }];
}

- (void)testPerformanceHTTPURIRFC3986Matches2
{
    [self measureMetrics:[XCTestCase defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        NSString *source = @"Along with our new #Twitterbird, we've also updated our Display Guidelines: https:\\dev.twitter.com\terms\\display-guidelines  ^JC";
        
        [self startMeasuring];
        [source ys_findHTTPURIRFC3986Matches];
        [self stopMeasuring];
    }];
}

@end
