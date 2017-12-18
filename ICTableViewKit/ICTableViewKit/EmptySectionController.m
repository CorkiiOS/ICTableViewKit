//
//  EmptySectionController.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "EmptySectionController.h"
#import "ICEmptyTableViewCell.h"
#import "EmptyViewController.h"
#import "ICTestObject.h"
@implementation EmptySectionController {
    ICTestObject *_object;
}

- (NSInteger)numberOfRows
{
    return 1;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index
{
    return 50;
}

- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index
{
    ICEmptyTableViewCell *cell = [self.tableViewContext dequeueReusableCellOfNibName:@"ICEmptyTableViewCell" forSectionController:self atIndex:index];
    cell.indexLabel.text = [NSString stringWithFormat:@"%@",_object.name];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    _object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    if (self.removeIndex) {
        self.removeIndex(self);
    }
}

@end
