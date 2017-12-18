//
//  ICEmptyTableViewCell.h
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICEmptyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (nonatomic, copy) void(^removeCallBack)(void);
@end
