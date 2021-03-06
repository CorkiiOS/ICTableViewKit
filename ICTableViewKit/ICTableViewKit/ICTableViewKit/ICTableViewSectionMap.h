//
//  ICTableViewSectionMap.h
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ICTableViewSectionController;

@interface ICTableViewSectionMap : NSObject

- (instancetype)initWithMapTable:(NSMapTable *)mapTable NS_DESIGNATED_INITIALIZER;

/**
 The objects stored in the map.
 */
@property (nonatomic, strong, readonly) NSArray *objects;

- (void)updateWithObjects:(NSArray *)objects sectionControllers:(NSArray *)sectionControllers;

- (nullable id)objectForSection:(NSInteger)section;

- (nullable ICTableViewSectionController *)sectionControllerForSection:(NSInteger)section;

- (NSInteger)sectionForSectionController:(ICTableViewSectionController *)sectionController;


- (nullable ICTableViewSectionController *)sectionControllerForObject:(id)object;

- (void)reset;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
