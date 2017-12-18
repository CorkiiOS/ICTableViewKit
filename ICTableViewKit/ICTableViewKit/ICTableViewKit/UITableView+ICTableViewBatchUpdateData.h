//
//  UITableView+ICTableViewBatchUpdateData.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICTableViewBatchUpdateData;

@interface UITableView (ICTableViewBatchUpdateData)

- (void)ic_applyBatchUpdateData:(ICTableViewBatchUpdateData *)updateData;

@end
