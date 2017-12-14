//
//  ICTableViewUpdater.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewUpdater.h"
#import "ICTableViewIndexSetResult.h"
#import "ICTableViewDiff.h"
@interface ICTableViewUpdater()
@property (nonatomic, copy, nullable) NSArray *fromObjects;
@property (nonatomic, copy, nullable) NSArray *toObjects;

@end

@implementation ICTableViewUpdater


- (void)performUpdateWithTableView:(UITableView *)tableView
                       fromObjects:(NSArray<id<ICTableViewDiffable>> *)fromObjects
                         toObjects:(NSArray<id<ICTableViewDiffable>> *)toObjects
                          animated:(BOOL)animated
                        completion:(IGListUpdatingCompletion)completion {
    self.fromObjects = fromObjects;
    self.toObjects = toObjects;
    
    ICTableViewIndexSetResult *(^performDiff)(void) = ^ICTableViewIndexSetResult * {
        return ICTableViewDiffExperiment(fromObjects, toObjects);
    };
    
    // block that executes the batch update and exception handling
    void (^performUpdate)(ICTableViewIndexSetResult *) = ^(ICTableViewIndexSetResult *result) {
        
    };

    ICTableViewIndexSetResult *result = performDiff();
    
    performUpdate(result);
    
}

@end
