//
//  JKAnalisParaModel.h
//  Pods
//
//  Created by jianke on 16/6/22.
//
//
//#import <Foundation/Foundation.h>

@interface JKAnalisParaModel : NSObject


/**
 * 用户的唯一标示
 */
@property (nonatomic, strong) NSString *AppKey;

/**
 * 用户的唯一标示
 */
@property (nonatomic, strong) NSString *UserId;
/**
 * 用户是否登录
 */
@property (nonatomic, strong) NSString *UserFlag;
/**
 * 当前页面的标示
 */
@property (nonatomic, strong) NSString *pageId;
/**
 * 上一个页面的标示
 */
@property (nonatomic, strong) NSString *Referrer;
/**
 * 时间戳
 */
@property (nonatomic, strong) NSString *Timestamp;
/**
 * 事件id
 */
@property (nonatomic, strong) NSString *eventId;
/**
 * 页面停留时间
 */
@property (nonatomic, strong) NSString *duration;
/**
 * 常用的参数
 */
@property (nonatomic, strong) NSString *extras;
/**
 * 一些传递的参数
 */
@property (nonatomic, strong) NSString *param;

@end


@interface JKextrasModel : NSObject
/**
 * 设备唯一标识符
 */
@property (nonatomic, strong) NSString *uuid;
/**
 * 设备唯一标识符
 */
@property (nonatomic, strong) NSString *udid;
/**
 * 广告唯一标示符
 */
@property (nonatomic, strong) NSString *adid;
/**
 * 设备品牌
 */
@property (nonatomic, strong) NSString *brand;
/**
 * 设备型号
 */
@property (nonatomic, strong) NSString *model;
/**
 * 设备破屏幕尺寸
 */
@property (nonatomic, strong) NSString *screen;
/**
 * 设备系统类型
 */
@property (nonatomic, strong) NSString *os;
/**
 * 设备系统版本号
 */
@property (nonatomic, strong) NSString *osVersion;
/**
 * 应用的版本
 */
@property (nonatomic, strong) NSString *clientVersion;
/**
 * clientBuild
 */
@property (nonatomic, strong) NSString *clientBuild;
/**
 * 地理信息
 */
@property (nonatomic, strong) NSString *geo;
/**
 * 网络类型
 */
@property (nonatomic, strong) NSString *networkType;
/**
 * 下载渠道
 */
@property (nonatomic, strong) NSString *channel;

@end
