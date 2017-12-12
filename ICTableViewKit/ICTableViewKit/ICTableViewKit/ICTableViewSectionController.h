//
//  ICTableViewSectionController.h
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ICTableViewContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface ICTableViewSectionController : NSObject

@property (nonatomic, assign, readonly) NSInteger section;

@property (nonatomic, weak, readwrite) UIViewController *viewController;

@property (nonatomic, weak, readwrite) id <ICTableViewContext> tableViewContext;

- (NSInteger)numberOfRows;

- (CGFloat)heightForRowAtIndex:(NSInteger)index;

- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index;

- (CGFloat)heightForHeader;

- (CGFloat)heightForFooter;

- (UIView *)sectionHeaderView;

- (UIView *)sectionFooterView;

- (void)didUpdateToObject:(id)object;

- (void)didSelectItemAtIndex:(NSInteger)index;

- (void)didDeselectItemAtIndex:(NSInteger)index;

- (void)didHighlightItemAtIndex:(NSInteger)index;

- (void)didUnhighlightItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
