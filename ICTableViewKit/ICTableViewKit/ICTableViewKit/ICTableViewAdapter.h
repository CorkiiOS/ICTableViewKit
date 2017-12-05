//
//  ICTableViewAdapter.h
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ICTableViewAdapterDataSource.h"
NS_ASSUME_NONNULL_BEGIN


@class ICTableViewSectionMap, ICTableViewSectionController;


@interface ICTableViewAdapter : NSObject


- (instancetype)initViewController:(UIViewController *)viewController;



@property (nonatomic, nullable, weak) id <ICTableViewAdapterDataSource> dataSource;

@property (nonatomic, nullable, weak) UIViewController *viewController;

@property (nonatomic, nullable, weak) UITableView *tableView;

@property (nonatomic, strong, readonly) ICTableViewSectionMap *sectionMap;



- (nullable ICTableViewSectionController *)sectionControllerForSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
