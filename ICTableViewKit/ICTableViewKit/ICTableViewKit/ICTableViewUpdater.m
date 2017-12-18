//
//  ICTableViewUpdater.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewUpdater.h"
#import "ICTableViewIndexSetResult.h"
#import "ICTableViewBatchUpdateData.h"
#import "ICTableViewBatchUpdates.h"
#import "UITableView+ICTableViewBatchUpdateData.h"
#import "ICTableViewDiff.h"
@interface ICTableViewUpdater()
@property (nonatomic, copy, nullable) NSArray *fromObjects;
@property (nonatomic, copy, nullable) NSArray *toObjects;
@property (nonatomic, copy) ICTableViewObjectTransitionBlock objectTransitionBlock;
@property (nonatomic, strong, nullable) ICTableViewBatchUpdateData *applyingUpdateData;

@property (nonatomic, strong) ICTableViewBatchUpdates *batchUpdates;

@end

@implementation ICTableViewUpdater

- (void)cleanStateAfterUpdates {
    self.batchUpdates = [ICTableViewBatchUpdates new];
}

- (void)performUpdateWithTableView:(UITableView *)tableView
                       fromObjects:(NSArray<id<ICTableViewDiffable>> *)fromObjects
                         toObjects:(NSArray<id<ICTableViewDiffable>> *)toObjects
                          animated:(BOOL)animated
            objectTransitionBlock:(ICTableViewObjectTransitionBlock)objectTransitionBlock
                        completion:(ICTableViewUpdatingCompletion)completion {
    
    self.fromObjects = fromObjects;
    self.toObjects = toObjects;
    self.objectTransitionBlock = objectTransitionBlock;
    //执行更新
    void (^executeUpdateBlocks)(void) = ^{
        
        //执行更新操作之前，首先更新数据
        if (objectTransitionBlock) {
            objectTransitionBlock(toObjects);
        }
    };
    
    //批量执行完成block
    void (^excuteCompletionBlocks)(BOOL) = ^(BOOL finished) {
        
    };
    
    //刷新数据回退
    void (^reloadDataFallback)(void) = ^{
        [tableView reloadData];
        [tableView layoutIfNeeded];
        excuteCompletionBlocks(YES);
    };
    
    ICTableViewIndexSetResult *(^performDiff)(void) = ^ICTableViewIndexSetResult * {
        return ICTableViewDiffExperiment(fromObjects, toObjects, ICTableViewDiffEquality);
    };
    
    //批量更新操作
    void (^batchUpdatesBlock)(ICTableViewIndexSetResult *result) = ^(ICTableViewIndexSetResult *result){
        executeUpdateBlocks();
        
        self.applyingUpdateData = [self flushTableView:tableView withDiffResult:result batchUpdates:self.batchUpdates fromObjects:fromObjects];
        
        [self cleanStateAfterUpdates];
       
    };

    
    //批量更新完成
    void (^batchUpdatesCompletionBlock)(BOOL) = ^(BOOL finished) {
        
     
    };
    
    // block that executes the batch update and exception handling
    void (^performUpdate)(ICTableViewIndexSetResult *) = ^(ICTableViewIndexSetResult *result) {
        
        @try {
            //将要执行更新操作
            //改变的数量过大 执行回退操作 少条件
            if (result.changeCount > 100) {
                reloadDataFallback();
            }else if (animated) {
                [tableView performBatchUpdates:^{
                    batchUpdatesBlock(result);
                } completion:batchUpdatesCompletionBlock];
            }else {
                [CATransaction begin];
                [CATransaction setDisableActions:YES];
                [tableView performBatchUpdates:^{
                    batchUpdatesBlock(result);
                } completion:^(BOOL finished) {
                    batchUpdatesCompletionBlock(finished);
                }];
                
            }
            
        }@catch (NSException *exception){
            //更新操作执行产生异常
            @throw exception;
        }
       
    };

    ICTableViewIndexSetResult *result = performDiff();
    
    performUpdate(result);
    
}

- (ICTableViewBatchUpdateData *)flushTableView:(UITableView *)tableView
                                     withDiffResult:(ICTableViewIndexSetResult *)diffResult
                                       batchUpdates:(ICTableViewBatchUpdates *)batchUpdates
                                        fromObjects:(NSArray <id<ICTableViewDiffable>> *)fromObjects {
    
    // combine section reloads from the diff and manual reloads via reloadItems:
    NSMutableIndexSet *reloads = [diffResult.updates mutableCopy];
//    [reloads addIndexes:batchUpdates.sectionReloads];
    
    NSMutableIndexSet *inserts = [diffResult.inserts mutableCopy];
    NSMutableIndexSet *deletes = [diffResult.deletes mutableCopy];
//    if (self.movesAsDeletesInserts) {
//        for (IGListMoveIndex *move in moves) {
//            [deletes addIndex:move.from];
//            [inserts addIndex:move.to];
//        }
//        // clear out all moves
//        moves = [NSSet new];
//    }
    
    // reloadSections: is unsafe to use within performBatchUpdates:, so instead convert all reloads into deletes+inserts
//    convertReloadToDeleteInsert(reloads, deletes, inserts, diffResult, fromObjects);
    
    NSMutableArray<NSIndexPath *> *itemInserts = batchUpdates.itemInserts;
    NSMutableArray<NSIndexPath *> *itemDeletes = batchUpdates.itemDeletes;
//    NSMutableArray<IGListMoveIndexPath *> *itemMoves = batchUpdates.itemMoves;
    
    NSSet<NSIndexPath *> *uniqueDeletes = [NSSet setWithArray:itemDeletes];
    NSMutableSet<NSIndexPath *> *reloadDeletePaths = [NSMutableSet new];
    NSMutableSet<NSIndexPath *> *reloadInsertPaths = [NSMutableSet new];
//    for (IGListReloadIndexPath *reload in batchUpdates.itemReloads) {
//        if (![uniqueDeletes containsObject:reload.fromIndexPath]) {
//            [reloadDeletePaths addObject:reload.fromIndexPath];
//            [reloadInsertPaths addObject:reload.toIndexPath];
//        }
//    }
    [itemDeletes addObjectsFromArray:[reloadDeletePaths allObjects]];
    [itemInserts addObjectsFromArray:[reloadInsertPaths allObjects]];
    
    ICTableViewBatchUpdateData *updateData = [[ICTableViewBatchUpdateData alloc] initWithInsertSections:inserts deleteSections:deletes insertIndexPaths:itemInserts deleteIndexPaths:itemDeletes];
    [tableView ic_applyBatchUpdateData:updateData];
    return updateData;
}

@end
