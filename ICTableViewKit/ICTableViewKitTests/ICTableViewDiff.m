//
//  ICTableViewDiff.m
//  ICTableViewKitTests
//
//  Created by 王志刚 on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ICTableViewDiff.h"
#import "ICTestObject.h"
@interface ICTableViewDiff : XCTestCase

@end

@implementation ICTableViewDiff

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testDiffDelete {
    NSMutableArray *oldArray = @[].mutableCopy;
    NSMutableArray *newArray = @[].mutableCopy;
    
    for (NSInteger i = 0; i < 5; i ++) {
        ICTestObject *object = [ICTestObject new];
        object.key = i;
        object.name = [NSString stringWithFormat:@"iCorki + %ld",i];
        [oldArray addObject:object];
    }
    
    for (NSInteger i = 0; i < 10; i ++) {
        ICTestObject *object = [ICTestObject new];
        object.key = i;
        object.name = [NSString stringWithFormat:@"iCorki + %ld",i];
        if (i == 3) {
            object.name = @"张三";
        }
        
        if (i == 4) {
            continue;
        }
        
        [newArray addObject:object];
    }
    
    
// new @5 Nsnot  0x6040002a68b8  0x6040002a6978    0x6000002a6a38 0x6040002a69d8 0x6000002a6c18
// old @4       0x6040002a68b8(0)    0x6040002a6978(1)  0x6000002a6a38(2) 0x6000002a6918(3) 0x6000002a6c18(4)
    /*0x6040002a68b8    0x6040002a68b8 0 @1
      0x6040002a6978    0x6040002a6978 1 @2
      0x6000002a6a38    0x6000002a6a38 2 @3
      0x6040002a69d8 @4 0x6000002a6918 3 @5
      0x6000002a6c18    0x6000002a6c18 4 @6
     */
    
    ICTableViewIndexSetResult *result = ICTableViewDiffExperiment(oldArray, newArray);
    
    
}

- (void)testDiffInsert {
    NSArray *oldArray = @[@1, @2, @3, @4, @6];
    NSArray *newArray = @[@1, @2, @3, @4, @6, @8];
    ICTableViewIndexSetResult *result = ICTableViewDiffExperiment(oldArray, newArray);
    NSInteger insertIndex = result.inserts.firstIndex;
    NSAssert(insertIndex == 5, @"测试成功");
}

- (void)testDiffUpdate {
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
