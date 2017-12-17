//
//  ICTableViewDiff.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICTableViewIndexSetResult.h"
#import "ICTableViewDiffable.h"
#import "ICTableViewIndexPathResult.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ICTableViewDiffOption) {
    /**
     Compare objects using pointer personality. 指针比较
     */
    ICTableViewDiffPointerPersonality,
    /**
     Compare objects using `-[IGListDiffable isEqualToDiffableObject:]`. 自定义比较
     */
    ICTableViewDiffEquality
};

FOUNDATION_EXPORT ICTableViewIndexSetResult *ICTableViewDiff(
                                                             NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                             NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                             ICTableViewDiffOption option);

FOUNDATION_EXPORT ICTableViewIndexPathResult *ICTableViewDiffPath(NSInteger fromSection,
                                                                  NSInteger toSection,
                                                                  NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                                  NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                                  ICTableViewDiffOption option);


FOUNDATION_EXPORT ICTableViewIndexSetResult *ICTableViewDiffExperiment(
                                                                       NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                                       NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                                       ICTableViewDiffOption option);

FOUNDATION_EXPORT ICTableViewIndexPathResult *ICTableViewDiffPathExperiment(NSInteger fromSection,
                                                                            NSInteger toSection,
                                                                            NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                                            NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                                            ICTableViewDiffOption option);



NS_ASSUME_NONNULL_END
