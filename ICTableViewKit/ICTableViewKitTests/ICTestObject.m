//
//  ICTestObject.m
//  ICTableViewKitTests
//
//  Created by 王志刚 on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTestObject.h"

@implementation ICTestObject

- (id<NSObject>)diffIdentifier {
    return @(self.key);
}

- (BOOL)isEqualToDiffableObject:(id<ICTableViewDiffable>)object {
    ICTestObject *o = object;
    if ([object isKindOfClass:[ICTestObject class]]) {
        return [self.name isEqualToString:o.name];
    }
    return NO;
}
@end
