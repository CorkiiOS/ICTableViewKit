//
//  ICTableViewSectionMap.m
//  ICTableViewKit
//
//  Created by 王志刚 on 2017/12/5.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewSectionMap.h"
#import "NormalSectionController.h"

@interface ICTableViewSectionMap()

/**
 object - sectionController
 */
@property (nonatomic, strong, readonly, nonnull) NSMapTable<id, ICTableViewSectionController *> *objectToSectionControllerMap;

@property (nonatomic, strong, readonly, nonnull) NSMapTable<ICTableViewSectionController *, NSNumber *> *sectionControllerToSectionMap;

@property (nonatomic, strong, nonnull) NSMutableArray *mObjects;

@end

@implementation ICTableViewSectionMap

- (instancetype)initWithMapTable:(NSMapTable *)mapTable
{
    self = [super init];
    if (self)
    {
        _objectToSectionControllerMap = [mapTable copy];
        _sectionControllerToSectionMap = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory | NSMapTableObjectPointerPersonality valueOptions:NSMapTableStrongMemory capacity:0];
        
        _mObjects = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)objects
{
    return self.mObjects.copy;
}

- (nullable id)objectForSection:(NSInteger)section {
    NSArray *objects = self.mObjects;
    if (section < objects.count) {
        return objects[section];
    } else {
        return nil;
    }
}

- (nullable ICTableViewSectionController *)sectionControllerForSection:(NSInteger)section
{
    return [self.objectToSectionControllerMap objectForKey:[self objectForSection:section]];
}

- (nullable ICTableViewSectionController *)sectionControllerForObject:(id)object
{
    
    return [self.objectToSectionControllerMap objectForKey:object];
}

- (void)updateWithObjects:(NSArray *)objects sectionControllers:(NSArray *)sectionControllers {
    
    self.mObjects = [objects mutableCopy];

    [objects enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        ICTableViewSectionController *sectionController = sectionControllers[idx];
        
        // set the index of the list for easy reverse lookup
        [self.sectionControllerToSectionMap setObject:@(idx) forKey:sectionController];
        [self.objectToSectionControllerMap setObject:sectionController forKey:object];
        [self.objectToSectionControllerMap setObject:sectionController forKey:object];
    }];
}

@end
