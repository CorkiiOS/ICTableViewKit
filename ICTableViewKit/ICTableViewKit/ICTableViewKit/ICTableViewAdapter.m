//
//  ICTableViewAdapter.m
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewAdapter.h"
#import "ICTableViewAdapter+UITableView.h"
#import "ICTableViewSectionMap.h"

@implementation ICTableViewAdapter

- (instancetype)initViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        
//        NSPointerFunctions *valueFunctions = [NSPointerFunctions pointerFunctionsWithOptions:NSPointerFunctionsStrongMemory];

        NSMapTable *table = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
        _sectionMap = [[ICTableViewSectionMap alloc] initWithMapTable:table];
        _viewController = viewController;
    }
    return self;
}

- (nullable ICTableViewSectionController *)sectionControllerForSection:(NSInteger)section
{
    return [self.sectionMap sectionControllerForSection:section];
}

- (void)updateObjects:(NSArray *)objects dataSource:(id<ICTableViewAdapterDataSource>)dataSource
{
    ICTableViewSectionMap *map = self.sectionMap;

    NSMutableArray<ICTableViewSectionController *> *sectionControllers = [NSMutableArray new];
    NSMutableArray *validObjects = [NSMutableArray new];
    
    for (id object in objects) {
        
        // infra checks to see if a controller exists
        ICTableViewSectionController *sectionController = [map sectionControllerForObject:object];
        
        // if not, query the data source for a new one
        if (sectionController == nil) {
            sectionController = [dataSource listAdapter:self sectionControllerForObject:object];
        }
        
        if (sectionController == nil) {
//            IGLKLog(@"WARNING: Ignoring nil section controller returned by data source %@ for object %@.",
//                    dataSource, object);
            continue;
        }
        
        [sectionControllers addObject:sectionController];
        [validObjects addObject:object];
        
        // in case the section controller was created outside of -listAdapter:sectionControllerForObject:
//        sectionController.collectionContext = self;
//        sectionController.viewController = self.viewController;
        
        // check if the item has changed instances or is new
//        const NSInteger oldSection = [map sectionForObject:object];
//        if (oldSection == NSNotFound || [map objectForSection:oldSection] != object) {
//            [updatedObjects addObject:object];
//        }
        
        //[sectionControllers addObject:sectionController];
        
//#if DEBUG
//        IGAssert([NSSet setWithArray:sectionControllers].count == sectionControllers.count,
//                 @"Section controllers array is not filled with unique objects; section controllers are being reused");
//#endif
        //[validObjects addObject:object];
    }
    [map updateWithObjects:validObjects sectionControllers:sectionControllers];


}

- (void)setDataSource:(id<ICTableViewAdapterDataSource>)dataSource
{
    _dataSource = dataSource;
    [self updateObjects:[self.dataSource objectsForListAdapter:self] dataSource:dataSource];
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

@end
