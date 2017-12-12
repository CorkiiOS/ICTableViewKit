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
#import "ICTableViewContext.h"
#import "ICTableViewSectionController.h"

NS_INLINE NSString *ICTableViewReusableViewIdentifier(Class viewClass, NSString * _Nullable nibName) {
    return [NSString stringWithFormat:@"%@%@", nibName ?: @"", NSStringFromClass(viewClass)];
}

@interface ICTableViewAdapter()<ICTableViewContext>

@property (nonatomic, strong) NSMutableSet *registerCellClasses;
@property (nonatomic, strong) NSMutableSet *registerNibNames;
@property (nonatomic, strong) NSMutableSet *registerHeaderFooterViewClasses;
@property (nonatomic, strong) NSMutableSet *registerHeaderFooterViewNibNames;

@end

 @implementation ICTableViewAdapter

- (instancetype)initViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        
//        NSPointerFunctions *valueFunctions = [NSPointerFunctions pointerFunctionsWithOptions:NSPointerFunctionsStrongMemory];

        NSMapTable *table = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
        _sectionMap = [[ICTableViewSectionMap alloc] initWithMapTable:table];
        _viewController = viewController;
        
        _registerCellClasses = [NSMutableSet set];
        _registerNibNames = [NSMutableSet set];
        _registerHeaderFooterViewClasses = [NSMutableSet set];
        _registerHeaderFooterViewNibNames = [NSMutableSet set];
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
            sectionController.tableViewContext = self;
            sectionController.viewController = self.viewController;
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

- (NSIndexPath *)indexPathForSectionController:(ICTableViewSectionController *)controller
                                         index:(NSInteger)index {
    ICTableViewSectionMap *map = self.sectionMap;
    const NSInteger section = [map sectionForSectionController:controller];
    if (section == NSNotFound) {
        return nil;
    } else {
        return [NSIndexPath indexPathForRow:index inSection:section];
    }
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

- (nullable __kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index sectionController:(ICTableViewSectionController *)sectionController {
    return nil;
}

- (nullable __kindof UITableViewCell *)dequeueReusableCellOfClass:(nonnull Class)cellClass forSectionController:(nonnull ICTableViewSectionController *)sectionController atIndex:(NSInteger)index {
    
    UITableView *tableView = self.tableView;
    
//    IGAssert(collectionView != nil, @"Dequeueing cell of class %@ from section controller %@ without a collection view at index %zi", NSStringFromClass(cellClass), sectionController, index);
    NSString *identifier = ICTableViewReusableViewIdentifier(cellClass, nil);
    NSIndexPath *indexPath = [self indexPathForSectionController:sectionController index:index];
    if (![self.registerCellClasses containsObject:cellClass]) {
        [self.registerCellClasses addObject:cellClass];
        [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (nullable __kindof UITableViewCell *)dequeueReusableCellOfNibName:(nonnull NSString *)nibName forSectionController:(nonnull ICTableViewSectionController *)sectionController atIndex:(NSInteger)index {
    
    UITableView *tableView = self.tableView;
    NSString *identifier = ICTableViewReusableViewIdentifier(nil, nibName);
    NSIndexPath *indexPath = [self indexPathForSectionController:sectionController index:index];
    if (![self.registerNibNames containsObject:nibName]) {
        [self.registerNibNames addObject:nibName];
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (nullable UIView *)dequeueReusableHeaderFooterViewWithNibName:(nonnull NSString *)nibName forSectionController:(nonnull ICTableViewSectionController *)sectionController {
    
    UITableView *tableView = self.tableView;
    NSString *identifier = ICTableViewReusableViewIdentifier(nil, nibName);
    if (![self.registerHeaderFooterViewNibNames containsObject:nibName]) {
        [self.registerHeaderFooterViewNibNames addObject:nibName];
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}


- (nullable UIView *)dequeueReusableHeaderFooterViewWithViewClass:(nonnull Class)viewClass forSectionController:(nonnull ICTableViewSectionController *)sectionController {
    UITableView *tableView = self.tableView;
    NSString *identifier = ICTableViewReusableViewIdentifier(viewClass, nil);
    if (![self.registerHeaderFooterViewClasses containsObject:viewClass]) {
        [self.registerHeaderFooterViewClasses addObject:viewClass];
        [tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:identifier];
    }
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

@end
