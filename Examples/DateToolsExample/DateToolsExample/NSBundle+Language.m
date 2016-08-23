//
//  NSBundle+Language.m
//
//
//  Created by Yeung Yiu Hung on 11/9/15.
//

#import "NSBundle+Language.h"

#import <objc/runtime.h>

static const char _bundle=0;

@interface BundleEx : NSBundle
@end

@implementation BundleEx
-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle* bundle=objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}
@end

@implementation NSBundle (Language)
+(void)setLanguage:(NSString*)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      object_setClass([NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DTError class]] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]],[BundleEx class]);
                  });
    objc_setAssociatedObject([NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DTError class]] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DTError class]] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
