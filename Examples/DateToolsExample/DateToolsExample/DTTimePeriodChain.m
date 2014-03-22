//
//  DTTimePeriodChain.m
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import "DTTimePeriodChain.h"

@implementation DTTimePeriodChain

#pragma mark - Chain Existence Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period{
    if (periods) {
        if (periods.count > 0) {
            //Create a modified period to be added based on size of passed in period
            DTTimePeriod *modifiedPeriod = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds startingAt:[periods[periods.count - 1] EndDate]];
            
            //Set helper variables
            self.EndDate = modifiedPeriod.EndDate;
            self.Last = modifiedPeriod;
            
            //Add object to periods array
            [periods addObject:modifiedPeriod];
        }
        else {
            //Add object to periods array
            [periods addObject:period];
            
            //Set object's variables with updated array values
            [self upateVariables];
        }
    }
    else {
        //Create new periods array
        periods = [NSMutableArray array];
        
        //Add object to periods array
        [periods addObject:period];
        
        //Set object's variables with updated array values
        [self upateVariables];
    }
}

-(void)insertTimePeriod:(DTTimePeriod *)period atInedx:(NSInteger)index{
    //Make sure the index is within the operable bounds of the periods array
    if (index >= 0 && index < (periods.count - 1)) {
        if (index == 0) {
            //Update bounds of period to make it fit in chain
            DTTimePeriod *modifiedPeriod = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds endingAt:[periods[0] EndDate]];
            
            //Insert the updated object at the beginning of the periods array
            [periods insertObject:modifiedPeriod atIndex:0];
        }
        else {
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
        }
        
        //Set object's variables with updated array values
        [self upateVariables];
    }
    else {
        //Handle Error
    }
}

-(void)removeTimePeriodAtIndex:(NSInteger)index{
    //Make sure the index is within the operable bounds of the periods array
    if (index >= 0 && index < periods.count) {
        DTTimePeriod *period = periods[index];
        
        //Shift time periods later if they fall after new period
        [periods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //Shift later
            if (idx > index) {
                [((DTTimePeriod *) obj) shiftEarlierWithSize:DTTimePeriodSizeSecond amount:period.durationInSeconds];
            }
        }];
    
        //Set object's variables with updated array values
        [self upateVariables];
    }
    else {
        //Handle Error
    }
}
-(void)removeLatestTimePeriod{
    if (periods.count > 0) {
        [periods removeLastObject];
        
        //Update the object variables
        if (periods.count > 0) {
            //Set object's variables with updated array values
            [self upateVariables];
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
        
        //Update the object variables
        if (periods.count > 0) {
            //Set object's variables with updated array values
            [self upateVariables];
        }
        else {
            [self setVariablesNil];
        }
    }
    
    //Set object's variables with updated array values
    [self upateVariables];
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
    }
}


#pragma mark - Helper Methods

-(void)upateVariables{
    //Set helper variables
    self.StartDate = [periods[0] StartDate];
    self.EndDate = [periods[periods.count - 1] EndDate];
    self.First = periods[0];
    self.Last = periods[periods.count -1];
}

-(void)setVariablesNil{
    //Set helper variables
    self.StartDate = nil;
    self.EndDate = nil;
    self.First = nil;
    self.Last = nil;
}

@end
