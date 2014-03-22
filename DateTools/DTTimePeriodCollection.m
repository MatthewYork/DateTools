//
//  DTTimePeriodCollection.m
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import "DTTimePeriodCollection.h"
#import "DTError.h"

@implementation DTTimePeriodCollection

#pragma mark - Custom Init / Factory Methods
+(DTTimePeriodCollection *)collection{
    return [[DTTimePeriodCollection alloc] init];
}

#pragma mark - Collection Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period{
    if ([period isKindOfClass:[DTTimePeriod class]]) {
        [periods addObject:period];
    }
    else {
        [DTError throwBadTypeException:period];
    }
}

-(void)insertTimePeriod:(DTTimePeriod *)period atInedx:(NSInteger)index{
    if ([period isKindOfClass:[DTTimePeriod class]]) {
        if (index >= 0 && index < (periods.count - 1)) {
            [periods insertObject:period atIndex:index];
        }
        else {
            [DTError throwInsertOutOfBoundsException:index array:periods];
        }
    }
    else {
        [DTError throwBadTypeException:period];
    }
}

-(void)removeTimePeriodAtIndex:(NSInteger)index{
    if (index >= 0 && index < (periods.count - 1)) {
        [periods removeObjectAtIndex:index];
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

-(void)sortByStart{
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

#pragma mark - Collection Operations
-(DTTimePeriodCollection *)periodsInside:(DTTimePeriod *)period{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    return collection;
}
-(DTTimePeriodCollection *)periodsIntersectedByDate:(NSDate *)date{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    return collection;
}
-(DTTimePeriodCollection *)periodsIntersectedByPeriod:(DTTimePeriod *)period{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    return collection;
}
-(DTTimePeriodCollection *)periodsOverlappedByPeriod:(DTTimePeriod *)period{
    DTTimePeriodCollection *collection = [[DTTimePeriodCollection alloc] init];
    
    return collection;
}

@end
