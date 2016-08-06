//
//  JKAnalytics.h
//  JKAnalytics
//
//  Created by 郑喜荣 on 16/6/1.
//  Copyright © 2016年 season. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKAnalytics : NSObject
#pragma mark basics

+ (JKAnalytics *)shareAnalytics;

/** 初始化统计模块
 @param appKey 友盟appKey.
 @return void
 */
- (void)startWithAppkey:(NSString *)appKey;

- (void)setUserId:(NSString *)UserId;

- (void)setUserFlag:(NSString *)UserFlag;

- (void)beginLogPageView:(NSString *)pageName params:(NSString *)params;

/** 自动页面时长统计, 结束记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 @return void.
 */
- (void)endLogPageView:(NSString *)pageName ;

#pragma mark event logs

/**
 @param  eventId 网站上注册的事件Id.
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  accumulation 累加值。为减少网络交互，可以自行对某一事件ID的某一分类标签进行累加，再传入次数作为参数。
 @return void.
 */
- (void)event:(NSString *)eventId pageId:(NSString *)pageId; 

@end
