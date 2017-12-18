//
//  ICTableViewBatchUpdateData.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICTableViewBatchUpdateData : NSObject

/**
 Section insert indexes.
 */
@property (nonatomic, strong, readonly) NSIndexSet *insertSections;

/**
 Section delete indexes.
 */
@property (nonatomic, strong, readonly) NSIndexSet *deleteSections;


/**
 Item insert index paths.
 */
@property (nonatomic, strong, readonly) NSArray<NSIndexPath *> *insertIndexPaths;

/**
 Item delete index paths.
 */
@property (nonatomic, strong, readonly) NSArray<NSIndexPath *> *deleteIndexPaths;

- (instancetype)initWithInsertSections:(NSIndexSet *)insertSections
                        deleteSections:(NSIndexSet *)deleteSections
                      insertIndexPaths:(NSArray<NSIndexPath *> *)insertIndexPaths
                      deleteIndexPaths:(NSArray<NSIndexPath *> *)deleteIndexPaths
                                                        NS_DESIGNATED_INITIALIZER;

/**
 :nodoc:
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 :nodoc:
 */
+ (instancetype)new NS_UNAVAILABLE;

@end
