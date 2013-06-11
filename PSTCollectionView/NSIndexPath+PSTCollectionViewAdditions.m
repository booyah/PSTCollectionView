//
//  NSIndexPath+PSTCollectionViewAdditions.m
//  PSTCollectionView
//
//  Copyright (c) 2013 Peter Steinberger. All rights reserved.
//

#import "NSIndexPath+PSTCollectionViewAdditions.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000

@implementation NSIndexPath (PSTCollectionViewAdditions)

// Simple NSIndexPath addition to allow using "item" instead of "row".
+ (NSIndexPath *)indexPathForItem:(NSInteger)item inSection:(NSInteger)section {
    return [NSIndexPath indexPathForRow:item inSection:section];
}

- (NSInteger)item {
    return self.row;
}

@end

#ifdef APPORTABLE

// TODO(jeff): This is temporary until their platform implements it.

@implementation NSIndexSet (Enumeration)

- (void)enumerateIndexesUsingBlock:(void (^)(NSUInteger idx, BOOL *stop))block {
    const NSUInteger count = [self count];
    NSUInteger* indexes = malloc(count * sizeof(NSUInteger));
    // TODO(elliot): Log if OOM.

    NSUInteger packed = [self getIndexes:indexes maxCount:count inIndexRange:nil];
    NSAssert(packed == count, @"Da fuq?");
    // TODO(elliot): Log if packed != count.

    BOOL stop = NO;
    for (NSUInteger i = 0; i < count; ++i) {
        if (stop) break;
        block(indexes[i], &stop);
    }
    free(indexes);
}

@end

#endif

#endif
