//
//  DateToolProvider.m
//  DateToolsExample
//
//  Created by Shahiya on 4/6/16.
//
//

#import "DateToolsProvider.h"
#import <objc/runtime.h>

@interface BundleEx : NSBundle
@end

static const char _bundle=0;

@implementation BundleEx
-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
  NSBundle* bundle=objc_getAssociatedObject(self, &_bundle);
  return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}
@end

@implementation DateToolsProvider

+(void)setDateToolsLanguage:(NSString *)language {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^
                {
                  object_setClass([NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DTError class]] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]],[BundleEx class]);
                });
  objc_setAssociatedObject([NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DTError class]] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle bundleWithPath:[[[NSBundle bundleForClass:[DTError class]] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
