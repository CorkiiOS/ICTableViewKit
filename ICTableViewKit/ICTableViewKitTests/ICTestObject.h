//
//  ICTestObject.h
//  ICTableViewKitTests
//
//  Created by 王志刚 on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICTableViewDiff.h"
@interface ICTestObject : NSObject<ICTableViewDiffable>
@property (nonatomic, assign) NSInteger key;

@property (nonatomic, strong) NSString * name;

@end
