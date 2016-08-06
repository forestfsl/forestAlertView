//
//  JKAnalytics.m
//  JKAnalytics
//
//  Created by 郑喜荣 on 16/6/1.
//  Copyright © 2016年 season. All rights reserved.
//

#import "JKAnalytics.h"
#import <AFNetworking/AFNetworking.h>
#import "JKAnaliseDatabase.h"
#import "JKAnalisParaModel.h"
#import <AdSupport/ASIdentifierManager.h>
#import "JKNetWorkEngine+JKAnalytics.h"
#import "JKSystemparamHelper.h"
#import "JKJsonHelp.h"

@interface JKAnalytics ()

@property (nonatomic, assign)int max_id;
@property (nonatomic, strong) NSString *UserId;
@property (nonatomic, strong) NSString *UserFlag;
@property (nonatomic, strong) NSString *Referrer;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) JKextrasModel *extrasModel;
@property (nonatomic, strong) JKAnalisParaModel *paraModel;
@property (nonatomic, assign) long startTime;

@end
@implementation JKAnalytics

static JKAnalytics *Analytics = nil;

+ (JKAnalytics *)shareAnalytics{
    if (Analytics == nil) {
        Analytics = [[JKAnalytics alloc] init];
    }
    return Analytics;

}

- (void)startWithAppkey:(NSString *)appKey {
    
    self.appKey = [appKey copy];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendRequest) userInfo:nil repeats:YES];
    
}



- (void)setUserId:(NSString *)UserId {
    
    _UserId = [UserId copy];
}

- (void)setUserFlag:(NSString *)UserFlag {
    
    _UserFlag = [UserFlag copy];
}

//这两个地方用两个时间戳相减得到时间差
- (void)beginLogPageView:(NSString *)pageName params:(NSString *)params{
    

}
- (void)beginLogPageView:(NSString *)pageName {
    self.startTime =  (long long)((double)[[NSDate date] timeIntervalSince1970] *1000);
}

- (void)endLogPageView:(NSString *)pageName {
    
    self.duration = [NSString stringWithFormat:@"%lld", (long long)((double)[[NSDate date] timeIntervalSince1970] *1000) - self.startTime];
    [self event:nil pageId:pageName];
    self.duration = nil;
    
}

- (void)event:(NSString *)eventId pageId:(NSString *)pageId {
   
    //1，获取一些常用的参数赋值给模型
    self.paraModel.AppKey = self.appKey;
    self.paraModel.UserId = self.UserId;//根据
    self.paraModel.UserFlag = self.UserFlag;
    self.paraModel.pageId = pageId;
    self.paraModel.Referrer = self.Referrer;
    self.paraModel.Timestamp = [NSString stringWithFormat:@"%lld", (long long)((double)[[NSDate date] timeIntervalSince1970] *1000)];
    self.paraModel.eventId = eventId;
    self.paraModel.duration = self.duration;
    NSDictionary *dic = @{
                          @"uuid" : self.extrasModel.uuid,
                          @"udid" : self.extrasModel.udid,
                          @"adid" : self.extrasModel.adid,
                          @"brand" : self.extrasModel.brand,
                          @"model" : self.extrasModel.model,
                          @"screen" : self.extrasModel.screen,
                          @"os" : self.extrasModel.os,
                          @"osVersion" : self.extrasModel.osVersion,
                          @"clientVersion" : self.extrasModel.clientVersion,
                          @"clientBuild" : self.extrasModel.clientBuild,
                          @"geo" : self.extrasModel.geo,
                          @"networkType" : self.extrasModel.networkType,
                          @"channel" : self.extrasModel.channel
                          };
    NSString *extras = [JKJsonHelp toJsonString:dic];
    self.paraModel.extras = extras;
    //TODO:
    NSDictionary *dict = @{
                          };
    NSString *param = [JKJsonHelp toJsonString:dict];
    self.paraModel.param = param;
    //2，储存数据
    [[JKAnaliseDatabase sharedDatabase] saveData:self.paraModel];
    self.Referrer = pageId;
    
}


- (void)sendRequest{
    
    int max_id = [[JKAnaliseDatabase sharedDatabase] getMaxId];//max_id要存起来
    self.max_id = max_id;
    NSArray *array = [[JKAnaliseDatabase sharedDatabase] seleteAllAnalisParaModelDataToMaxid:max_id];
    NSLog(@"array = %@",array);
    NSString *josnStr = [JKJsonHelp toJsonString:array];
    //当array里面有值的时候直接将array发送过去
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{
        @"body" : josnStr
    };
    if (array.count) {
        [[[JKNetWorkEngine alloc] init] dispatchParameteron:dic Succeeded:^(NSMutableDictionary *aDictionary) {
            [[JKAnaliseDatabase sharedDatabase] deleteData:self.max_id];
        } onError:^(NSError *engineError) {
            
        }];
    }
    
}

- (JKextrasModel *)extrasModel
{
    if (_extrasModel == nil) {
        _extrasModel = [[JKextrasModel alloc] init];
        _extrasModel.udid = [[JKSystemparamHelper shareSystemparamHelper] UDID];
        _extrasModel.uuid = [[JKSystemparamHelper shareSystemparamHelper] UDID];
        _extrasModel.adid = [JKSystemparamHelper adid];
        _extrasModel.brand = @"Apple";
        _extrasModel.model = [JKSystemparamHelper model];
        _extrasModel.screen = [JKSystemparamHelper screen];
        _extrasModel.os = @"ios";
        _extrasModel.osVersion = [JKSystemparamHelper osVersion];
        _extrasModel.clientVersion = [JKSystemparamHelper appVersion];
        _extrasModel.clientBuild = [JKSystemparamHelper clientBuild];
        _extrasModel.geo = @"";
        _extrasModel.networkType = @"";
        _extrasModel.channel = @"App Store";
        
    }
    return _extrasModel;

}
- (JKAnalisParaModel *)paraModel
{
    if (_paraModel == nil) {
        _paraModel = [[JKAnalisParaModel alloc] init];
    }
    return _paraModel;
}
- (NSString *)Referrer
{
    if (_Referrer == nil) {
        _Referrer = [NSString string];
    }
    return  _Referrer;
}
@end
