//
//  ICTableViewIndexSetResult.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewIndexSetResult.h"

@implementation ICTableViewIndexSetResult {
    NSMapTable<id<NSObject>, NSNumber *> *_oldIndexMap;
    NSMapTable<id<NSObject>, NSNumber *> *_newIndexMap;

}

- (instancetype)initWithInserts:(NSIndexSet *)inserts
                        deletes:(NSIndexSet *)deletes
                        updates:(NSIndexSet *)updates
                    oldIndexMap:(NSMapTable<id<NSObject>, NSNumber *> *)oldIndexMap
                    newIndexMap:(NSMapTable<id<NSObject>, NSNumber *> *)newIndexMap {
    if (self = [super init]) {
        _inserts = [inserts copy];
        _deletes = [deletes copy];
        _updates = [updates copy];
        _oldIndexMap = oldIndexMap;
        _newIndexMap = newIndexMap;
    }
    return self;
}

- (BOOL)hasChanges {
    return self.changeCount > 0;
}

- (NSInteger)changeCount {
    return self.inserts.count + self.deletes.count + self.updates.count;
}

- (NSInteger)oldIndexForIdentifier:(id<NSObject>)identifier {
    NSNumber *index = [_oldIndexMap objectForKey:identifier];
    return index == nil ? NSNotFound : [index integerValue];
}

- (NSInteger)newIndexForIdentifier:(id<NSObject>)identifier {
    NSNumber *index = [_newIndexMap objectForKey:identifier];
    return index == nil ? NSNotFound : [index integerValue];
}

@end
