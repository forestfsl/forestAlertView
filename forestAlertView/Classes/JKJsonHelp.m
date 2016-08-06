//
//  JKJsonHelp.m
//  Pods
//
//  Created by jianke on 16/6/21.
//
//

#import "JKJsonHelp.h"

@implementation JKJsonHelp

#pragma mark----- 将Json字符串转为Dictionary或者Array对象
+(id)toJsonObject:(NSString *)string error:(NSError **)error
{
    if (string == nil) return nil;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:NSJSONReadingAllowFragments
                                             error:error];
}

+ (id)toJsonObject:(NSString *)string {
    return [self toJsonObject:string error:nil];
}

+ (id)fromResource:(NSString *)resouce ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:resouce ofType:type];
    NSError  *error;
    NSString *jsonStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    assert(error == nil);
    return [JKJsonHelp toJsonObject:jsonStr];
}

#pragma mark ---- 将对象转换为Json字符串
+(NSString *)toJsonString:(id)object error:(NSError **)error
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:error];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)toJsonString:(id)object {
    if (object == nil) return nil;
    return [self toJsonString:object error:nil];
}

+(NSString *)toJsonString:(id)object prettyPrint:(BOOL)pretty error:(NSError **)error
{
    NSString *result = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:error];
    if( error == nil && [jsonData length] > 0 ){
        result = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        if(!pretty){
            result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        }
    }
    
    return result;
}

+ (NSString *)toJsonString:(id)object prettyPrint:(BOOL)pretty {
    return [self toJsonString:object prettyPrint:pretty error:nil];
}

@end