//
//  ICTableViewAdapterDataSource.h
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ICTableViewSectionController, ICTableViewAdapter;

@protocol ICTableViewAdapterDataSource <NSObject>

- (NSArray *)objectsForListAdapter:(ICTableViewAdapter *)listAdapter;

- (ICTableViewSectionController *)listAdapter:(ICTableViewAdapter *)listAdapter sectionControllerForObject:(id)object;

- (nullable UIView *)emptyViewForListAdapter:(ICTableViewAdapter *)listAdapter;

@end

NS_ASSUME_NONNULL_END
