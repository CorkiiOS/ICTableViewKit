//
//  ICTableViewDiffable.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICTableViewDiffable <NSObject>

- (nonnull id<NSObject>)diffIdentifier;

- (BOOL)isEqualToDiffableObject:(nullable id<ICTableViewDiffable>)object;

@end
