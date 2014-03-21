//
//  DTTimePeriodGroup.h
//  DateToolsExample
//
//  Created by Matthew York on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "DTTimePeriod.h"

@interface DTTimePeriodGroup : NSObject {
@protected
    NSMutableArray *periods;
}

@property NSDate *Start;
@property NSDate *End;

//Here we will use object subscripting to help create the illusion of an array
- (id)objectAtIndexedSubscript:(NSUInteger)index; //getter
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index; //setter
@end
