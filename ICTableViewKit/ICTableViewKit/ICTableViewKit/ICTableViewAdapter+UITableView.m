//
//  ICTableViewAdapter+UITableView.m
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewAdapter+UITableView.h"
#import "ICTableViewSectionMap.h"
#import "ICTableViewSectionController.h"
@implementation ICTableViewAdapter (UITableView)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ICTableViewSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    UITableViewCell *cell = [sectionController cellForRowAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sectionMap sectionControllerForSection:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionMap.objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ICTableViewSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    CGFloat height = [sectionController heightForRowAtIndex:indexPath.row];
    
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ICTableViewSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    [sectionController didSelectItemAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [[self.sectionMap sectionControllerForSection:section] heightForHeader];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [[self.sectionMap sectionControllerForSection:section] heightForFooter];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[self.sectionMap sectionControllerForSection:section] sectionHeaderView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[self.sectionMap sectionControllerForSection:section] sectionFooterView];
}
@end
