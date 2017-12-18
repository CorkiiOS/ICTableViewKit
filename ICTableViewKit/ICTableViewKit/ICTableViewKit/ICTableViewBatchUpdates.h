//
//  ICTableViewBatchUpdates.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICTableViewBatchUpdates : NSObject

@property (nonatomic, strong, readonly) NSMutableIndexSet *sectionReloads;
@property (nonatomic, strong, readonly) NSMutableArray<NSIndexPath *> *itemInserts;
@property (nonatomic, strong, readonly) NSMutableArray<NSIndexPath *> *itemDeletes;

@property (nonatomic, strong, readonly) NSMutableArray<void (^)()> *itemUpdateBlocks;
@property (nonatomic, strong, readonly) NSMutableArray<void (^)(BOOL)> *itemCompletionBlocks;

- (BOOL)hasChanges;

@end
