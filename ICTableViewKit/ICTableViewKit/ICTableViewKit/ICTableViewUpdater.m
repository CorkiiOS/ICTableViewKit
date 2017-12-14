//
//  ICTableViewUpdater.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewUpdater.h"
#import "ICTableViewIndexSetResult.h"
#import "ICTableViewDiff.h"
@interface ICTableViewUpdater()
@property (nonatomic, copy, nullable) NSArray *fromObjects;
@property (nonatomic, copy, nullable) NSArray *toObjects;

@end

@implementation ICTableViewUpdater


- (void)performUpdateWithTableView:(UITableView *)tableView
                       fromObjects:(NSArray<id<ICTableViewDiffable>> *)fromObjects
                         toObjects:(NSArray<id<ICTableViewDiffable>> *)toObjects
                          animated:(BOOL)animated
                        completion:(IGListUpdatingCompletion)completion {
    self.fromObjects = fromObjects;
    self.toObjects = toObjects;
    
    //执行更新
    void (^executeUpdateBlocks)(void) = ^{
        
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
        return ICTableViewDiffExperiment(fromObjects, toObjects);
    };
    
    //批量更新操作
    void (^batchUpdatesBlock)(ICTableViewIndexSetResult *result) = ^(ICTableViewIndexSetResult *result){
        executeUpdateBlocks();
        
       
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

@end
