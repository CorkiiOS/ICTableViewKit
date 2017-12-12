//
//  NormalSectionController.m
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "NormalSectionController.h"

@implementation NormalSectionController

- (NSInteger)numberOfRows
{
    return 16;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index
{
    return 50;
}

- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index
{
    UITableViewCell *cell = [self.tableViewContext dequeueReusableCellOfClass:[UITableViewCell class] forSectionController:self atIndex:index];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",index];
    return cell;
}

- (CGFloat)heightForFooter {
    return 40;
}

- (CGFloat)heightForHeader {
    return 80;
}

- (UIView *)sectionHeaderView {
    UIView *view = [self.tableViewContext dequeueReusableHeaderFooterViewWithNibName:@"ICHeaderFooterView" forSectionController:self];
    return view;
}

- (UIView *)sectionFooterView {
    UIView *view = [self.tableViewContext dequeueReusableHeaderFooterViewWithNibName:@"ICHeaderFooterView" forSectionController:self];
    return view;
}

- (void)didUpdateToObject:(id)object {
    
    
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"%ld",index);
    [self.viewController.navigationController pushViewController:[UIViewController new] animated:YES];
    
}

@end
