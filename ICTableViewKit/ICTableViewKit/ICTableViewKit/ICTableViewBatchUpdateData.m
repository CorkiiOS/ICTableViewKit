//
//  ICTableViewBatchUpdateData.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewBatchUpdateData.h"

@implementation ICTableViewBatchUpdateData

- (instancetype)initWithInsertSections:(NSIndexSet *)insertSections
                        deleteSections:(NSIndexSet *)deleteSections
                      insertIndexPaths:(NSArray<NSIndexPath *> *)insertIndexPaths
                      deleteIndexPaths:(NSArray<NSIndexPath *> *)deleteIndexPaths {

    if (self = [super init]) {
        NSMutableIndexSet *mDeleteSections = [deleteSections mutableCopy];
        NSMutableIndexSet *mInsertSections = [insertSections mutableCopy];
        
        // these collections should NEVER be mutated during cleanup passes, otherwise sections that have multiple item
        // changes (e.g. a moved section that has a delete + reload on different index paths w/in the section) will only
        // convert one of the item changes into a section delete+insert. this will fail hard and be VERY difficult to
        // debug
       
        NSMutableArray<NSIndexPath *> *mInsertIndexPaths = [insertIndexPaths mutableCopy];
        // avoid a flaky UICollectionView bug when deleting from the same index path twice
        // exposes a possible data source inconsistency issue
        NSMutableArray<NSIndexPath *> *mDeleteIndexPaths = [[[NSSet setWithArray:deleteIndexPaths] allObjects] mutableCopy];
        
       
        _deleteSections = [mDeleteSections copy];
        _insertSections = [mInsertSections copy];
        _deleteIndexPaths = [mDeleteIndexPaths copy];
        _insertIndexPaths = [mInsertIndexPaths copy];
    }
    return self;
}

@end
