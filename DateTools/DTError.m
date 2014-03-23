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
    //Handle possible zero bounds
    NSInteger arrayUpperBound = (array.count == 0)? 0:array.count;
    
    //Create info for error
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil), NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Attempted to insert DTTimePeriod at index %d but the group is of size [0...%d].", index, arrayUpperBound],NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try an index within the bounds or the group.", nil)};
    
    //Handle Error
    NSError *error = [NSError errorWithDomain:DTErrorDomain code:DTInsertOutOfBoundsException userInfo:userInfo];
    [self printErrorWithCallStack:error];
}

+(void)throwRemoveOutOfBoundsException:(NSInteger)index array:(NSArray *)array{
    //Handle possible zero bounds
    NSInteger arrayUpperBound = (array.count == 0)? 0:array.count;
    
    //Create info for error
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil), NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Attempted to remove DTTimePeriod at index %d but the group is of size [0...%d].", index, arrayUpperBound],NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try an index within the bounds of the group.", nil)};
    
    //Handle Error
    NSError *error = [NSError errorWithDomain:DTErrorDomain code:DTRemoveOutOfBoundsException userInfo:userInfo];
    [self printErrorWithCallStack:error];
}

+(void)throwBadTypeException:(id)obj expectedClass:(Class)classType{
    //Create info for error
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil), NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Attempted to insert object of class %@ when expecting object of class %@.", NSStringFromClass([obj class]), NSStringFromClass(classType)],NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please try again by inserting a DTTimePeriod object.", nil)};
    
    //Handle Error
    NSError *error = [NSError errorWithDomain:DTErrorDomain code:DTBadTypeException userInfo:userInfo];
    [self printErrorWithCallStack:error];
}

+(void)printErrorWithCallStack:(NSError *)error{
    //Print error
    NSLog(@"%@", error);
    
    //Print call stack
    for (NSString *symbol in [NSThread callStackSymbols]) {
        NSLog(@"\n\n %@", symbol);
    }
}
@end
