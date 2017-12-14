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

FOUNDATION_EXPORT ICTableViewIndexSetResult *ICTableViewDiffExperiment(NSArray<id<ICTableViewDiffable>> *_Nullable oldArraty, NSArray<id<ICTableViewDiffable>> * _Nullable newArray);

NS_ASSUME_NONNULL_END
