//
//  ICTableViewBatchUpdates.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewBatchUpdates.h"

@implementation ICTableViewBatchUpdates

- (instancetype)init {
    if (self = [super init]) {
        _sectionReloads = [NSMutableIndexSet new];
        _itemInserts = [NSMutableArray new];
        _itemDeletes = [NSMutableArray new];
        _itemUpdateBlocks = [NSMutableArray new];
        _itemCompletionBlocks = [NSMutableArray new];
    }
    return self;
}

@end
