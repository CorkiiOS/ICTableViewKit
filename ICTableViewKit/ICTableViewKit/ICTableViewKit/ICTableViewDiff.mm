//
//  ICTableViewDiff.m
//  ICTableViewKit
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 王志刚. All rights reserved.
//

#import "ICTableViewDiff.h"
#import <stack>
#import <vector>
#import <unordered_map>

using namespace std;

struct ICTableViewEntry {
    NSInteger newCounter = 0;
    NSInteger oldCounter = 0;
    stack<NSInteger> oldIndexs;
    BOOL updated = NO;
};

struct ICTableViewRecord {
    ICTableViewEntry *entry;
    mutable NSInteger index;

    ICTableViewRecord() {
        entry = NULL;
        index = NSNotFound;
    }
};

static id<NSObject> ICTableViewTableKey(id<ICTableViewDiffable> object) {
    id<NSObject> key = [object diffIdentifier];
    if (key == nil) {
        //异常处理
    }
    return key;
}

struct ICTableViewHashID {
    size_t operator()(const id o) const {
        return (size_t)[o hash];
    }
};

struct ICTableViewEqualID {
    bool operator()(const id a, const id b) const {
        return (a == b) || [a isEqual: b];
    }
};

static id ICTableViewDiffing(BOOL returnIndexPaths,
                             NSInteger fromSction,
                             NSInteger toSection,
                             NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                             NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                             ICTableViewDiffOption option) {
    const NSInteger oldCount = oldArray.count;
    const NSInteger newCount = newArray.count;

    unordered_map<id<NSObject>, ICTableViewEntry, ICTableViewHashID, ICTableViewEqualID> table;

    vector<ICTableViewRecord> newResultArray(newCount);
    for (NSInteger i = 0 ; i < newCount; i ++) {

        id<NSObject>key = ICTableViewTableKey(newArray[i]);
        ICTableViewEntry &entry = table[key];
        entry.oldIndexs.push(NSNotFound);
        entry.newCounter ++;
        newResultArray[i].entry = &entry;

    }

    vector<ICTableViewRecord> oldResultArray(oldCount);
    for (NSInteger i = oldCount - 1; i >= 0; i --) {

        id<NSObject> key = ICTableViewTableKey(oldArray[i]);
        ICTableViewEntry &entry = table[key];
        entry.oldIndexs.push(i);
        entry.oldCounter ++;
        oldResultArray[i].entry = &entry;
    }

    for (NSInteger i = 0; i < newCount; i ++) {
        ICTableViewEntry *entry = newResultArray[i].entry;
        const NSInteger originalIndex = entry->oldIndexs.top();
        entry->oldIndexs.pop();
        
        if (originalIndex < oldCount) {
            const id<ICTableViewDiffable> n = newArray[i];
            const id<ICTableViewDiffable> o = oldArray[originalIndex];
            
            switch (option) {
                case ICTableViewDiffPointerPersonality:
                {
                    if (n != o) {
                        entry->updated = YES;
                    }
                }
                    break;
                    
                case ICTableViewDiffEquality:
                {
                    if (n != o && ![n isEqualToDiffableObject:o]) {
                        entry->updated = YES;
                    }
                }
                    break;
            }
           
        }
        
        if (originalIndex != NSNotFound &&
            entry->newCounter > 0 &&
            entry->oldCounter > 0) {

            newResultArray[i].index = originalIndex;
            oldResultArray[originalIndex].index = i;
        }
    }

    id mDeletes, mInserts, mUpdates;
    if (returnIndexPaths) {

    }else {
        mDeletes = [NSMutableIndexSet new];
        mInserts = [NSMutableIndexSet new];
        mUpdates = [NSMutableIndexSet new];
    }

    void (^addIndexToCollection)(id, NSInteger, NSInteger) = ^(id collection,
                                                               NSInteger section,
                                                               NSInteger index) {
        if (returnIndexPaths) {

        }else {
            [collection addIndex:index];
        }
    };

    NSMapTable *oldMap = [NSMapTable strongToStrongObjectsMapTable];
    NSMapTable *newMap = [NSMapTable strongToStrongObjectsMapTable];

    void (^addIndexToMap)(NSInteger, NSInteger, NSArray *, NSMapTable *) = ^(NSInteger section,
                                                                             NSInteger index,
                                                                             NSArray *array,
                                                                            NSMapTable *map){
        id value;
        if (returnIndexPaths) {

        }else {
            value = @(index);
        }
        [map setObject:value forKey:[array[index] diffIdentifier]];
    };

    vector<NSInteger> deleteOffsets(oldCount);
    for (NSInteger i = 0; i < oldCount; i ++) {

        const ICTableViewRecord record = oldResultArray[i];
        if (record.index == NSNotFound) {
            //delete
            addIndexToCollection(mDeletes, fromSction, i);
        }
        addIndexToMap(fromSction, i, oldArray, oldMap);;
    }

    for (NSInteger i = 0; i < newCount; i ++) {
        const ICTableViewRecord record = newResultArray[i];
        const NSInteger oldIndex = record.index;

        if (record.index == NSNotFound) {
            addIndexToCollection(mInserts, fromSction, i);
        }else {

            if (record.entry->updated) {
                addIndexToCollection(mUpdates, fromSction, i);
            }
        }
        addIndexToMap(toSection, i, newArray, newMap);
    }

    if (returnIndexPaths) {

        return nil;

    }else {
        return [[ICTableViewIndexSetResult alloc] initWithInserts:mInserts
                                                          deletes:mDeletes
                                                          updates:mUpdates
                                                      oldIndexMap:oldMap
                                                      newIndexMap:newMap];
    }
}


ICTableViewIndexSetResult *ICTableViewDiff(NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                           NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                           ICTableViewDiffOption option) {
    return ICTableViewDiffing(NO, 0, 0, oldArray, newArray, option);
}
                                           

ICTableViewIndexPathResult *ICTableViewDiffPath(NSInteger fromSection,
                                                NSInteger toSection,
                                                NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                ICTableViewDiffOption option) {
    return ICTableViewDiffing(YES, fromSection, toSection, oldArray, newArray, option);
}


ICTableViewIndexSetResult *ICTableViewDiffExperiment( NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                     NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                     ICTableViewDiffOption option) {
    return ICTableViewDiffing(NO, 0, 0, oldArray, newArray, option);

}
                                                     

ICTableViewIndexPathResult *ICTableViewDiffPathExperiment(NSInteger fromSection,
                                                          NSInteger toSection,
                                                          NSArray<id<ICTableViewDiffable>> *_Nullable oldArray,
                                                          NSArray<id<ICTableViewDiffable>> * _Nullable newArray,
                                                          ICTableViewDiffOption option) {
    return ICTableViewDiffing(YES, fromSection, toSection, oldArray, newArray, option);
}
                                                          




