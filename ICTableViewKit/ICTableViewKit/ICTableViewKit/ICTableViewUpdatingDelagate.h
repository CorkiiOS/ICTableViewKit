//
//  ICTableViewUpdatingDelagate.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ICTableViewDiffable;

typedef void (^ICTableViewUpdatingCompletion)(BOOL finished);
typedef void (^ICTableViewObjectTransitionBlock)(NSArray *toObjects);


@protocol ICTableViewUpdatingDelagate <NSObject>

- (void)performUpdateWithTableView:(UITableView *_Nullable)tableView
                            fromObjects:(nullable NSArray<id <ICTableViewDiffable>> *)fromObjects
                              toObjects:(nullable NSArray<id <ICTableViewDiffable>> *)toObjects
                               animated:(BOOL)animated
                  objectTransitionBlock:(ICTableViewObjectTransitionBlock)objectTransitionBlock
                             completion:(nullable ICTableViewUpdatingCompletion)completion;

@end

NS_ASSUME_NONNULL_END
