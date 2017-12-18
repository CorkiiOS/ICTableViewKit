//
//  ICEmptyTableViewCell.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICEmptyTableViewCell.h"

@implementation ICEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)removeIndexAction:(id)sender {
    if (self.removeCallBack) {
        self.removeCallBack();
    }
}



@end
