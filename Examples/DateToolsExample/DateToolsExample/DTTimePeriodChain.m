//
//  DTTimePeriodChain.m
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import "DTTimePeriodChain.h"
#import "DTError.h"

@interface DTTimePeriodChain ()
@property DTTimePeriod *First;
@property DTTimePeriod *Last;
@end

@implementation DTTimePeriodChain

#pragma mark - Custom Init / Factory Chain
+(DTTimePeriodChain *)chain{
    return [[DTTimePeriodChain alloc] init];
}

#pragma mark - Chain Existence Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period{
    if ([period class] != [DTTimePeriod class]) {
        [DTError throwBadTypeException:period expectedClass:[DTTimePeriod class]];
        return;
    }
    
    if (periods) {
        if (periods.count > 0) {
            //Create a modified period to be added based on size of passed in period
            DTTimePeriod *modifiedPeriod = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds startingAt:[periods[periods.count - 1] EndDate]];
            
            //Add object to periods array
            [periods addObject:modifiedPeriod];
        }
        else {
            //Add object to periods array
            [periods addObject:period];
        }
    }
    else {
        //Create new periods array
        periods = [NSMutableArray array];
        
        //Add object to periods array
        [periods addObject:period];
    }
    
    //Set object's variables with updated array values
    [self updateVariables];
}

-(void)insertTimePeriod:(DTTimePeriod *)period atInedx:(NSInteger)index{
    if ([period class] != [DTTimePeriod class]) {
        [DTError throwBadTypeException:period expectedClass:[DTTimePeriod class]];
        return;
    }
    
    //Make sure the index is within the operable bounds of the periods array
    if (index == 0) {
        //Update bounds of period to make it fit in chain
        DTTimePeriod *modifiedPeriod = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds endingAt:[periods[0] EndDate]];
        
        //Insert the updated object at the beginning of the periods array
        [periods insertObject:modifiedPeriod atIndex:0];
    }
    else if (index > 0 && index < periods.count) {
        
        //Shift time periods later if they fall after new period
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //Shift later
            if (idx >= index) {
                [((DTTimePeriod *) obj) shiftLaterWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds];
            }
        }];
        
        //Update bounds of period to make it fit in chain
        DTTimePeriod *modifiedPeriod = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds startingAt:[periods[index - 1] EndDate]];
        
        //Insert the updated object at the beginning of the periods array
        [periods insertObject:modifiedPeriod atIndex:index];
        
        //Set object's variables with updated array values
        [self updateVariables];
    }
    else {
        [DTError throwInsertOutOfBoundsException:index array:periods];
    }
}

-(void)removeTimePeriodAtIndex:(NSInteger)index{
    //Make sure the index is within the operable bounds of the periods array
    if (index >= 0 && index < periods.count) {
        DTTimePeriod *period = periods[index];
        
        //Shift time periods later if they fall after new period
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //Shift earlier
            if (idx > index) {
                [((DTTimePeriod *) obj) shiftEarlierWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds];
            }
        }];
        
        //Remove object
        [periods removeObjectAtIndex:index];
        
        //Set object's variables with updated array values
        [self updateVariables];
    }
    else {
        [DTError throwRemoveOutOfBoundsException:index array:periods];
    }
}
-(void)removeLatestTimePeriod{
    if (periods.count > 0) {
        [periods removeLastObject];
        
        //Update the object variables
        if (periods.count > 0) {
            //Set object's variables with updated array values
            [self updateVariables];
        }
        else {
            [self setVariablesNil];
        }
    }
}
-(void)removeEarliestTimePeriod{
    if (periods > 0) {
        //Shift time periods earlier
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //Shift earlier to account for removal of first element in periods array
            [((DTTimePeriod *) obj) shiftEarlierWithSize:DTTimePeriodSizeSecond amount:[periods[0] durationInSeconds]];
        }];
        
        //Remove first period
        [periods removeObjectAtIndex:0];
        
        //Update the object variables
        if (periods.count > 0) {
            //Set object's variables with updated array values
            [self updateVariables];
        }
        else {
            [self setVariablesNil];
        }
    }
}

#pragma mark - Chain Time Manipulation
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size{
    [self shiftEarlierWithSize:size amount:1];
}
-(void)shiftEarlierWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount{
    if (periods) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [((DTTimePeriod *)obj) shiftEarlierWithSize:size amount:amount];
        }];
        
        [self updateVariables];
    }
}
-(void)shiftLaterWithSize:(DTTimePeriodSize)size{
    [self shiftLaterWithSize:size amount:1];
}
-(void)shiftLaterWithSize:(DTTimePeriodSize)size amount:(NSInteger)amount{
    if (periods) {
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [((DTTimePeriod *)obj) shiftLaterWithSize:size amount:amount];
        }];
        
        [self updateVariables];
    }
}

#pragma mark - Chain Relationship
-(BOOL)isEqualToChain:(DTTimePeriodChain *)chain{
    //Check class
    if ([chain class] != [DTTimePeriodChain class]) {
        [DTError throwBadTypeException:chain expectedClass:[DTTimePeriodChain class]];
        return NO;
    }
    
    //Check group level characteristics for speed
    if (![self hasSameCharacteristicsAs:chain]) {
        return NO;
    }
    
    //Check whole chain
    __block BOOL isEqual = YES;
    [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![chain[idx] isEqualToPeriod:obj]) {
            isEqual = NO;
            *stop = YES;
        }
    }];
    return isEqual;
}

#pragma mark - Getters

-(DTTimePeriod *)First{
    return First;
}

-(DTTimePeriod *)Last{
    return Last;
}

#pragma mark - Helper Methods

-(void)updateVariables{
    //Set helper variables
    StartDate = [periods[0] StartDate];
    EndDate = [periods[periods.count - 1] EndDate];
    First = periods[0];
    Last = periods[periods.count -1];
}

-(void)setVariablesNil{
    //Set helper variables
    StartDate = nil;
    EndDate = nil;
    self.First = nil;
    self.Last = nil;
}

@end
