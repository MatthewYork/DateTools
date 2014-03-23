//
//  DTError.h
//  DateToolsExample
//
//  Created by Matthew York on 3/22/14.
//
//

#import <Foundation/Foundation.h>

#pragma mark - Domain
extern NSString *const DTErrorDomain;

#pragma mark - Status Codes
static const NSUInteger DTInsertOutOfBoundsException = 0;
static const NSUInteger DTRemoveOutOfBoundsException = 1;
static const NSUInteger DTBadTypeException = 2;

@interface DTError : NSObject

+(void)throwInsertOutOfBoundsException:(NSInteger)index array:(NSArray *)array;
+(void)throwRemoveOutOfBoundsException:(NSInteger)index array:(NSArray *)array;
+(void)throwBadTypeException:(id)obj expectedClass:(Class)classType;
@end
