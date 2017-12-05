//
//  ICTableViewSectionController.h
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ICTableViewSectionController : NSObject

- (NSInteger)numberOfRows;


- (CGFloat)heightForRowAtIndex:(NSInteger)index;


- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index;


- (void)didUpdateToObject:(id)object;


- (void)didSelectItemAtIndex:(NSInteger)index;


- (void)didDeselectItemAtIndex:(NSInteger)index;


- (void)didHighlightItemAtIndex:(NSInteger)index;


- (void)didUnhighlightItemAtIndex:(NSInteger)index;


@property (nonatomic, assign, readonly) NSInteger section;


@end
