//
//  EmptySectionController.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewSectionController.h"

@interface EmptySectionController : ICTableViewSectionController

@property (nonatomic, copy) void(^removeIndex)(EmptySectionController *);

@end
