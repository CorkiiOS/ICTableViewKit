//
//  ICTableViewUpdatingDelagate.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ICTableViewDiffable;

typedef void (^IGListUpdatingCompletion)(BOOL finished);


@protocol ICTableViewUpdatingDelagate <NSObject>

- (void)performUpdateWithTableView:(UITableView *_Nullable)tableView
                            fromObjects:(nullable NSArray<id <ICTableViewDiffable>> *)fromObjects
                              toObjects:(nullable NSArray<id <ICTableViewDiffable>> *)toObjects
                               animated:(BOOL)animated
                             completion:(nullable IGListUpdatingCompletion)completion;

@end
