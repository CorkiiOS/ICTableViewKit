//
//  UITableView+ICTableViewBatchUpdateData.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "UITableView+ICTableViewBatchUpdateData.h"
#import "ICTableViewBatchUpdateData.h"
@implementation UITableView (ICTableViewBatchUpdateData)

- (void)ic_applyBatchUpdateData:(ICTableViewBatchUpdateData *)updateData {
    
    [self deleteRowsAtIndexPaths:updateData.deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self insertRowsAtIndexPaths:updateData.insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self deleteSections:updateData.deleteSections withRowAnimation:UITableViewRowAnimationFade];
    [self insertSections:updateData.insertSections withRowAnimation:UITableViewRowAnimationFade];
    
    //    for (IGListMoveIndexPath *move in updateData.moveIndexPaths) {
    //        [self moveItemAtIndexPath:move.from toIndexPath:move.to];
    //    }
    //
    //    for (IGListMoveIndex *move in updateData.moveSections) {
    //        [self moveSection:move.from toSection:move.to];
    //    }
    //
}

@end
