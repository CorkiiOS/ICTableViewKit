//
//  ICTableViewIndexSetResult.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ICTableViewIndexSetResult : NSObject

@property (nonatomic, strong, readonly) NSIndexSet *inserts;

@property (nonatomic, strong, readonly) NSIndexSet *deletes;

@property (nonatomic, strong, readonly) NSIndexSet *updates;

@property (nonatomic, assign, readonly) BOOL hasChange;

@property (nonatomic, assign, readonly) NSInteger changeCount;

- (instancetype)initWithInserts:(NSIndexSet *)inserts
                        deletes:(NSIndexSet *)deletes
                        updates:(NSIndexSet *)updates
                    oldIndexMap:(NSMapTable<id<NSObject>, NSNumber *> *)oldIndexMap
                    newIndexMap:(NSMapTable<id<NSObject>, NSNumber *> *)newIndexMap NS_DESIGNATED_INITIALIZER;

- (NSInteger)oldIndexForIdentifier:(id<NSObject>)identifier;

- (NSInteger)newIndexForIdentifier:(id<NSObject>)identifier;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
