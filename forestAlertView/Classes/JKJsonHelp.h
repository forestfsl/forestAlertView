//
//  JKJsonHelp.h
//  Pods
//
//  Created by jianke on 16/6/21.
//
//

#import <Foundation/Foundation.h>

@interface JKJsonHelp : NSObject

/**
 * 将Json字符串转为Dictionary或者Array对象
 */
+ (id)toJsonObject:(NSString *)string error:(NSError **)error;

+ (id)toJsonObject:(NSString *)string;

+ (id)fromResource:(NSString *)resouce ofType:(NSString *)type;

/**
 * 将对象转换为Json字符串
 */
+ (NSString *)toJsonString:(id)object error:(NSError **)error;

+ (NSString *)toJsonString:(id)object;

/**
 * 将对象转换为Json字符串
 */
+ (NSString *)toJsonString:(id)object prettyPrint:(BOOL)pretty error:(NSError **)error;

+ (NSString *)toJsonString:(id)object prettyPrint:(BOOL)pretty;

@end
