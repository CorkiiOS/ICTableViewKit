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
#import "ICTableViewUpdatingDelagate.h"

NS_INLINE NSString *ICTableViewReusableViewIdentifier(Class viewClass, NSString * _Nullable nibName) {
    return [NSString stringWithFormat:@"%@%@", nibName ?: @"", NSStringFromClass(viewClass)];
}

@interface ICTableViewAdapter()<ICTableViewContext>

@property (nonatomic, strong) NSMutableSet *registerCellClasses;
@property (nonatomic, strong) NSMutableSet *registerNibNames;
@property (nonatomic, strong) NSMutableSet *registerHeaderFooterViewClasses;
@property (nonatomic, strong) NSMutableSet *registerHeaderFooterViewNibNames;

@property (nonatomic, strong) id<ICTableViewUpdatingDelagate> updater;

@end

 @implementation ICTableViewAdapter

- (void)dealloc {
    // on iOS 9 setting the dataSource has side effects that can invalidate the layout and seg fault
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        // properties are assign for <iOS 9
        _tableView.dataSource = nil;
        _tableView.delegate = nil;
    }
    
    [self.sectionMap reset];
}

- (instancetype)initWithUpdater:(id<ICTableViewUpdatingDelagate>)updater viewController:(UIViewController *)viewController
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
    NSMutableArray *updatedObjects = [NSMutableArray new];
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
        
        sectionController.tableViewContext = self;
        sectionController.viewController = self.viewController;
        
        [sectionControllers addObject:sectionController];
        [validObjects addObject:object];
        
        // in case the section controller was created outside of -listAdapter:sectionControllerForObject:
//        sectionController.collectionContext = self;
//        sectionController.viewController = self.viewController;
        
         //check if the item has changed instances or is new
        const NSInteger oldSection = [map sectionForSectionController:object];
        if (oldSection == NSNotFound || [map objectForSection:oldSection] != object) {
            [updatedObjects addObject:object];
        }
        
        [sectionControllers addObject:sectionController];
        
#if DEBUG
//        IGAssert([NSSet setWithArray:sectionControllers].count == sectionControllers.count,
//                 @"Section controllers array is not filled with unique objects; section controllers are being reused");
#endif
        [validObjects addObject:object];
    }
    [map updateWithObjects:validObjects sectionControllers:sectionControllers];
    
    for (id object in updatedObjects) {
        [[map sectionControllerForObject:object] didUpdateToObject:object];
    }
    
    NSInteger itemCount = 0;
    for (ICTableViewSectionController *sectionController in sectionControllers) {
        itemCount += [sectionController numberOfRows];
    }
    [self updateBackgroundViewShouldHide:itemCount > 0];

}

- (void)updateAfterPublicSettingsChange {
    id<ICTableViewAdapterDataSource> dataSource = _dataSource;
    if (_tableView != nil && dataSource != nil) {
        [self updateObjects:[dataSource objectsForListAdapter:self] dataSource:dataSource];
    }
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

- (void)updateBackgroundViewShouldHide:(BOOL)shouldHide {
    //加载数据首次不执行
    UIView *backgroundView = [self.dataSource emptyViewForListAdapter:self];
    // don't do anything if the client is using the same view
    if (backgroundView != _tableView.backgroundView) {
        // one first. also fine if it is nil
        [_tableView.backgroundView removeFromSuperview];
        _tableView.backgroundView = backgroundView;
    }
    _tableView.backgroundView.hidden = shouldHide;
}

- (void)setDataSource:(id<ICTableViewAdapterDataSource>)dataSource {
    _dataSource = dataSource;
    [self updateAfterPublicSettingsChange];
}

- (void)setTableView:(UITableView *)tableView {
    if (_tableView != tableView || _tableView.dataSource != self) {
        _tableView = tableView;
        _registerCellClasses = [NSMutableSet set];
        _registerNibNames = [NSMutableSet set];
        _registerHeaderFooterViewClasses = [NSMutableSet set];
        _registerHeaderFooterViewNibNames = [NSMutableSet set];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self updateAfterPublicSettingsChange];
    }
}

- (void)performUpdatesAnimated:(BOOL)animated completion:(IGTableViewUpdaterCompletion)completion {
    id<ICTableViewAdapterDataSource> dataSource = self.dataSource;
    
    NSArray *fromObjects = self.sectionMap.objects;
    NSArray *toObjects = [dataSource objectsForListAdapter:self];
    [self.updater performUpdateWithTableView:self.tableView
                                 fromObjects:fromObjects
                                   toObjects:toObjects
                                    animated:animated
                                  completion:^(BOOL finished) {
        
    }];
    
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
