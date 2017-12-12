//
//  ICTableViewContext.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICTableViewSectionController;

NS_ASSUME_NONNULL_BEGIN

@protocol ICTableViewContext <NSObject>

- (nullable __kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index
                                             sectionController:(ICTableViewSectionController *)sectionController;


- (nullable __kindof UITableViewCell *)dequeueReusableCellOfClass:(Class)cellClass forSectionController:(ICTableViewSectionController *)sectionController atIndex:(NSInteger)index;


- (nullable __kindof UITableViewCell *)dequeueReusableCellOfNibName:(NSString *)nibName forSectionController:(ICTableViewSectionController *)sectionController atIndex:(NSInteger)index;

- (nullable UIView *)dequeueReusableHeaderFooterViewWithViewClass:(Class)viewClass forSectionController:(ICTableViewSectionController *)sectionController;

- (nullable UIView *)dequeueReusableHeaderFooterViewWithNibName:(NSString *)nibName forSectionController:(ICTableViewSectionController *)sectionController;

@end

NS_ASSUME_NONNULL_END
