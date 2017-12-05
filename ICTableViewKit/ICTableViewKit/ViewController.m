//
//  ViewController.m
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ViewController.h"
#import "ICTableViewAdapter.h"
#import "NormalSectionController.h"
@interface ViewController ()<ICTableViewAdapterDataSource>
@property (nonatomic, strong) ICTableViewAdapter *adapter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    [self.view addSubview:tv];
    
    self.adapter.tableView = tv;
    self.adapter.dataSource = self;
    
    
}

- (ICTableViewAdapter *)adapter {
    if (_adapter == nil) {
        _adapter = [[ICTableViewAdapter alloc] initViewController:self];
    }
    return _adapter;
}

- (nullable UIView *)emptyViewForListAdapter:(nonnull ICTableViewAdapter *)listAdapter
{
    return nil;
}

- (nonnull ICTableViewSectionController *)listAdapter:(nonnull ICTableViewAdapter *)listAdapter sectionControllerForObject:(nonnull id)object
{
    return [NormalSectionController new];
}

- (nonnull NSArray *)objectsForListAdapter:(nonnull ICTableViewAdapter *)listAdapter
{
    return @[@1, @2, @3];
}



@end
