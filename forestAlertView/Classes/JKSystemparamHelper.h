//
//  JKSystemparamHelper.h
//  Pods
//
//  Created by jianke on 16/6/21.
//
//

#import <Foundation/Foundation.h>

/**
 * 系统信息帮助类
 */
@interface JKSystemparamHelper : NSObject

/**
 * 系统版本
 */
+ (NSString *)systemVersion;

/**
 * 应用版本号
 */
+ (NSString *)appVersion;

/**
 * 手机型号
 */
+ (NSString *)model;

/**
 * 手机adid
 */
+ (NSString *)adid;

/**
 * 手机系统版本
 */
+ (NSString *)osVersion;

/**
 * 手机clientBuild
 */
+ (NSString *)clientBuild;

/**
 * 手机屏幕尺寸
 */
+ (NSString *)screen;

/**
 * 单利
 */
+ (JKSystemparamHelper *)shareSystemparamHelper;

/**
 * 手机udid,用uuid来代替
 */
- (NSString *)UDID;
@end
