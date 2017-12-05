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
    return 1;
}


- (CGFloat)heightForRowAtIndex:(NSInteger)index
{
    return 50;
}


- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    
    return cell;
}


- (void)didUpdateToObject:(id)object {}


- (void)didSelectItemAtIndex:(NSInteger)index {}

@end
