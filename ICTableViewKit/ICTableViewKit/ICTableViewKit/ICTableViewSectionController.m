//
//  ICTableViewSectionController.m
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewSectionController.h"

@implementation ICTableViewSectionController

- (NSInteger)numberOfRows {
    return 1;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    return 0;
}

- (CGFloat)heightForHeader {
    return 0;
}

- (CGFloat)heightForFooter {
    return 0;
}

- (UIView *)sectionHeaderView {
    return nil;
}

- (UIView *)sectionFooterView {
    return nil;
}

- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    return nil;
}

- (void)didUpdateToObject:(id)object {}

- (void)didSelectItemAtIndex:(NSInteger)index {}

- (void)didDeselectItemAtIndex:(NSInteger)index {}

- (void)didHighlightItemAtIndex:(NSInteger)index {}

- (void)didUnhighlightItemAtIndex:(NSInteger)index {}

@end
