//
//  DTError.m
//  DateToolsExample
//
//  Created by Matthew York on 3/22/14.
//
//

#import "DTError.h"

#pragma mark - Domain
NSString *const DTErrorDomain = @"com.mattyork.dateTools";

@implementation DTError

+(void)throwInsertOutOfBoundsException:(NSInteger)index array:(NSArray *)array{
    //Create info for error
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil), NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Attempted to insert DTTimePeriod at index %d but the collection is of size [0...%d].", index, array.count-1],NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try an index within the bounds.", nil)};
    
    //Handle Error
    NSError *error = [NSError errorWithDomain:DTErrorDomain code:DTInsertOutOfBoundsException userInfo:userInfo];
    NSLog(@"%@", error);
}

+(void)throwRemoveOutOfBoundsException:(NSInteger)index array:(NSArray *)array{
    //Create info for error
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil), NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Attempted to remove DTTimePeriod at index %d but the collection is of size [0...%d].", index, array.count-1],NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try an index within the bounds.", nil)};
    
    //Handle Error
    NSError *error = [NSError errorWithDomain:DTErrorDomain code:DTInsertOutOfBoundsException userInfo:userInfo];
    NSLog(@"%@", error);
}

+(void)throwBadTypeException:(id)obj{
    //Create info for error
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil), NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Attempted to insert object of class %@ when expecting object of calss DTTimePeriod.", NSStringFromClass([obj class])],NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try again by inserting a DTTimePeriod object.", nil)};
    
    //Handle Error
    NSError *error = [NSError errorWithDomain:DTErrorDomain code:DTInsertOutOfBoundsException userInfo:userInfo];
    NSLog(@"%@", error);
}
@end
