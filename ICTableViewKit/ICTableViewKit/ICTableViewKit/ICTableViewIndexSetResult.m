//
//  ICTableViewIndexSetResult.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewIndexSetResult.h"

@implementation ICTableViewIndexSetResult

- (instancetype)initWithInserts:(NSIndexSet *)inserts
                        deletes:(NSIndexSet *)deletes
                        updates:(NSIndexSet *)updates
                    oldIndexMap:(NSMapTable<id<NSObject>, NSNumber *> *)oldIndexMap
                    newIndexMap:(NSMapTable<id<NSObject>, NSNumber *> *)newIndexMap {
    if (self = [super init]) {
        _inserts = [inserts copy];
        _deletes = [deletes copy];
        _updates = [updates copy];
    }
    return self;
}

@end
