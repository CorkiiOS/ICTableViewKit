//
//  EmptyViewController.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "EmptyViewController.h"
#import "ICTableViewAdapter.h"
#import "ICTableViewUpdater.h"
#import "EmptySectionController.h"
#import "ICTestObject.h"
@interface EmptyViewController ()<ICTableViewAdapterDataSource>
@property (nonatomic, strong) ICTableViewAdapter *adapter;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation EmptyViewController {
    NSInteger _maxI;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:tv];
    self.adapter.tableView = tv;
    self.adapter.dataSource = self;
    self.data = @[].mutableCopy;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(addAction)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (NSInteger i = 0; i < 15; i ++) {
            ICTestObject *object = [ICTestObject new];
            object.key = i;
            object.name = [NSString stringWithFormat:@"%zd 王大大", i + 1];
            [self.data addObject:object];
            _maxI = i;
        }
        [self.adapter performUpdatesAnimated:YES completion:nil];
    });
}

- (void)addAction {
    ICTestObject *object = [ICTestObject new];
    object.key = self.data.count + 10;
    object.name = [NSString stringWithFormat:@"%zd 王大大", _maxI + 1];
    [self.data addObject:object];
    [self.adapter performUpdatesAnimated:YES completion:nil];
    _maxI = self.data.count;
}

- (nullable UIView *)emptyViewForListAdapter:(nonnull ICTableViewAdapter *)listAdapter
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"暂无数据";
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (nonnull ICTableViewSectionController *)listAdapter:(nonnull ICTableViewAdapter *)listAdapter sectionControllerForObject:(nonnull id)object
{
    __weak typeof(self) weakSelf = self;

    EmptySectionController *empty = [EmptySectionController new];
    empty.removeIndex = ^(EmptySectionController *emptySection) {
        
        ICTestObject *object = [weakSelf.adapter objectForSection:[weakSelf.adapter sectionForSectionController:emptySection]];
        object.name = @"change da";
        [weakSelf.adapter performUpdatesAnimated:YES completion:nil];
    };
    return empty;
}

- (nonnull NSArray *)objectsForListAdapter:(nonnull ICTableViewAdapter *)listAdapter
{
    return self.data;
}

- (ICTableViewAdapter *)adapter {
    if (_adapter == nil) {
        _adapter = [[ICTableViewAdapter alloc] initWithUpdater:[ICTableViewUpdater new] viewController:self];
    }
    return _adapter;
}
@end
