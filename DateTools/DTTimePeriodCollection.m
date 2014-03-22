//
//  DTTimePeriodCollection.m
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import "DTTimePeriodCollection.h"
#import "DTError.h"
#import "NSDate+DateTools.h"

@implementation DTTimePeriodCollection

#pragma mark - Custom Init / Factory Methods
+(DTTimePeriodCollection *)collection{
    return [[DTTimePeriodCollection alloc] init];
}

#pragma mark - Collection Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period{
    if ([period isKindOfClass:[DTTimePeriod class]]) {
        [periods addObject:period];
        
        //Set object's variables with updated array values
        [self updateVariables];
    }
    else {
        [DTError throwBadTypeException:period expectedClass:[DTTimePeriod class]];
    }
}

-(void)insertTimePeriod:(DTTimePeriod *)period atIndex:(NSInteger)index{
    if ([period class] != [DTTimePeriod class]) {
        [DTError throwBadTypeException:period expectedClass:[DTTimePeriod class]];
        return;
    }
    
    if (index >= 0 && index < (periods.count - 1)) {
        [periods insertObject:period atIndex:index];
        
        //Set object's variables with updated array values
        [self updateVariables];
    }
    else {
        [DTError throwInsertOutOfBoundsException:index array:periods];
    }
}

-(void)removeTimePeriodAtIndex:(NSInteger)index{
    if (periods.count > 0) {
        if (index >= 0 && index < (periods.count - 1)) {
            [periods removeObjectAtIndex:index];
            
            //Update the object variables
            if (periods.count > 0) {
                //Set object's variables with updated array values
                [self updateVariables];
            }
            else {
                [self setVariablesNil];
            }
        }
        else {
            [DTError throwRemoveOutOfBoundsException:index array:periods];
        }
    }
    else {
        [DTError throwRemoveOutOfBoundsException:index array:periods];
    }
    
}

#pragma mark - Sorting
-(void)sortByStartAscending{
    [periods sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [((DTTimePeriod *) obj1).StartDate compare:((DTTimePeriod *) obj2).StartDate];
    }];
}

-(void)sortByStartDescending{
    [periods sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [((DTTimePeriod *) obj2).StartDate compare:((DTTimePeriod *) obj1).StartDate];
    }];
}

-(void)sortByEndAscending{
    [periods sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [((DTTimePeriod *) obj1).StartDate compare:((DTTimePeriod *) obj2).StartDate];
    }];
}

-(void)sortByEndDescending{
    [periods sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [((DTTimePeriod *) obj2).StartDate compare:((DTTimePeriod *) obj1).StartDate];
    }];
}

-(void)sortByDurationAscending{
    [periods sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (((DTTimePeriod *) obj1).durationInSeconds > ((DTTimePeriod *) obj2).durationInSeconds) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}

-(void)sortByDurationDescending{
    [periods sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (((DTTimePeriod *) obj1).durationInSeconds > ((DTTimePeriod *) obj2).durationInSeconds) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

#pragma mark - Collection Relationship
-(DTTimePeriodCollection *)periodsInside:(DTTimePeriod *)period{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    if ([period isKindOfClass:[DTTimePeriod class]]) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([((DTTimePeriod *) obj) isInside:period]) {
                [collection addTimePeriod:obj];
            }
        }];
    }
    else {
        [DTError throwBadTypeException:period expectedClass:[DTTimePeriod class]];
    }
    
    return collection;
}
-(DTTimePeriodCollection *)periodsIntersectedByDate:(NSDate *)date{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    if ([date isKindOfClass:[NSDate class]]) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([((DTTimePeriod *) obj) containsDate:date interval:DTTimePeriodIntervalClosed]) {
                [collection addTimePeriod:obj];
            }
        }];
    }
    else {
        [DTError throwBadTypeException:date expectedClass:[NSDate class]];
    }
    
    return collection;
}
-(DTTimePeriodCollection *)periodsIntersectedByPeriod:(DTTimePeriod *)period{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    if ([period isKindOfClass:[DTTimePeriod class]]) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([((DTTimePeriod *) obj) intersects:period]) {
                [collection addTimePeriod:obj];
            }
        }];
    }
    else {
        [DTError throwBadTypeException:period expectedClass:[DTTimePeriod class]];
    }
    
    return collection;
}
-(DTTimePeriodCollection *)periodsOverlappedByPeriod:(DTTimePeriod *)period{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([((DTTimePeriod *) obj) overlapsWith:period]) {
            [collection addTimePeriod:obj];
        }
    }];
    
    return collection;
}

-(BOOL)isEqualToCollection:(DTTimePeriodCollection *)collection considerOrder:(BOOL)considerOrder{
    //Check class
    if ([collection class] != [DTTimePeriodCollection class]) {
        [DTError throwBadTypeException:collection expectedClass:[DTTimePeriodCollection class]];
        return NO;
    }
    
    //Check group level characteristics for speed
    if (![self hasSameCharacteristicsAs:collection]) {
        return NO;
    }
    
    //Default to equality and look for inequality
    __block BOOL isEqual = YES;
    if (considerOrder) {
        
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![collection[idx] isEqualToPeriod:obj]) {
                isEqual = NO;
                *stop = YES;
            }
        }];
    }
    else {
        __block DTTimePeriodCollection *collectionCopy = [collection copy];
        
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __block BOOL innerMatch = NO;
            __block NSInteger matchIndex = 0; //We will remove matches to account for duplicates and to help speed
            for (int ii = 0; ii < collectionCopy.count; ii++) {
                if ([obj isEqualToPeriod:collectionCopy[ii]]) {
                    innerMatch = YES;
                    matchIndex = ii;
                    break;
                }
            }
            
            //If there was a match found, stop
            if (!innerMatch) {
                isEqual = NO;
                *stop = YES;
            }
            else {
                [collectionCopy removeTimePeriodAtIndex:matchIndex];
            }
        }];
    }
    
    return isEqual;
}

#pragma mark - Helper Methods

-(void)updateVariables{
    //Set helper variables
    __block NSDate *startDate = [NSDate distantFuture];
    __block NSDate *endDate = [NSDate distantPast];
    [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([((DTTimePeriod *) obj).StartDate isEarlierThan:startDate]) {
            startDate = ((DTTimePeriod *) obj).StartDate;
        }
        if ([((DTTimePeriod *) obj).EndDate isLaterThan:endDate]) {
            endDate = ((DTTimePeriod *) obj).EndDate;
        }
    }];
    
    //Make assignments after evaluation
    StartDate = startDate;
    EndDate = endDate;
}

-(void)setVariablesNil{
    //Set helper variables
    StartDate = nil;
    EndDate = nil;
}

-(DTTimePeriodCollection *)copy{
    DTTimePeriodCollection *collection = [DTTimePeriodCollection collection];
    
    [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [collection addTimePeriod:obj];
    }];
    
    return collection;
}

@end
