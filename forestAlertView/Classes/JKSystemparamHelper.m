//
//  JKSystemparamHelper.m
//  Pods
//
//  Created by jianke on 16/6/21.
//
//

#import "JKSystemparamHelper.h"
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import "SSKeychain.h"

@interface JKSystemparamHelper ()

@property (nonatomic,copy) NSString *UDID;

@end

@implementation JKSystemparamHelper

static JKSystemparamHelper *SystemparamHelper = nil;

+ (JKSystemparamHelper *)shareSystemparamHelper
{
    if (SystemparamHelper == nil) {
        SystemparamHelper = [[JKSystemparamHelper alloc] init];
    }
    return SystemparamHelper;
    
}

+ (NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)model {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    static NSDictionary *modelDict;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        modelDict = @{
                      @"i386"     : @"iPhone Simulator",
                      @"x86_64"   : @"iPhone Simulator",
                      @"iPhone1,1": @"iPhone 2G",
                      @"iPhone1,2": @"iPhone 3G",
                      @"iPhone2,1": @"iPhone 3GS",
                      @"iPhone3,1": @"iPhone 4(GSM)",
                      @"iPhone3,2": @"iPhone 4(GSM Rev A)",
                      @"iPhone3,3": @"iPhone 4(CDMA)",
                      @"iPhone4,1": @"iPhone 4S",
                      @"iPhone5,1": @"iPhone 5(GSM)",
                      @"iPhone5,2": @"iPhone 5(GSM+CDMA)",
                      @"iPhone5,3": @"iPhone 5c(GSM)",
                      @"iPhone5,4": @"iPhone 5c(Global)",
                      @"iPhone6,1": @"iphone 5s(GSM)",
                      @"iPhone6,2": @"iphone 5s(Global)",
                      @"iPhone7,1": @"iPhone 6 Plus",
                      @"iPhone7,2": @"iPhone 6",
                      @"iPhone8,1": @"iphone6S",
                      @"iphone8,2": @"iphone6S Plus",
                      @"iPod1,1"  : @"iPod Touch 1G",
                      @"iPod2,1"  : @"iPod Touch 2G",
                      @"iPod3,1"  : @"iPod Touch 3G",
                      @"iPod4,1"  : @"iPod Touch 4G",
                      @"iPod5,1"  : @"iPod Touch 5G",
                      @"iPad1,1"  : @"iPad",
                      @"iPad2,1"  : @"iPad 2(WiFi)",
                      @"iPad2,2"  : @"iPad 2(GSM)",
                      @"iPad2,3"  : @"iPad 2(CDMA)",
                      @"iPad2,4"  : @"iPad 2(WiFi + New Chip)",
                      @"iPad2,5"  : @"iPad mini (WiFi)",
                      @"iPad2,6"  : @"iPad mini (GSM)",
                      @"iPad2,7"  : @"ipad mini (GSM+CDMA)",
                      @"iPad3,1"  : @"iPad 3(WiFi)",
                      @"iPad3,2"  : @"iPad 3(GSM+CDMA)",
                      @"iPad3,3"  : @"iPad 3(GSM)",
                      @"iPad3,4"  : @"iPad 4(WiFi)",
                      @"iPad3,5"  : @"iPad 4(GSM)",
                      @"iPad3,6"  : @"iPad 4(GSM+CDMA)",
                      @"iPad4,1"  : @"iPad Air(WiFi)",
                      @"iPad4,2"  : @"iPad Air(GSM+CDMA)",
                      @"iPad4,3"  : @"iPad Air(GSM+TD)",
                      @"iPad4,4"  : @"iPad Mini 2G(WiFi)",
                      @"iPad4,5"  : @"iPad Mini 2G(GSM+CDMA)",
                      @"iPad4,6"  : @"iPad Mini 2G(GSM+TD)"
                      };
    });
    
    NSString *model = modelDict[machineString];
    
    
    return model == nil ? machineString : model;
}
+ (NSString *)adid
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)clientBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)screen
{
    return [NSString stringWithFormat:@"%f*%f",[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height];
}

- (NSString *)UDID {
    if (_UDID == nil){
        NSString *serviceString = [NSString stringWithFormat:@".com.jianke.JKAnalytics"];
        NSString *serviceUDIDStr = @"ServiceUDID";
        NSError *error = nil;
        
        //保存UDID到keychain(生成相对固定的UDID）
        NSString *password = [SSKeychain passwordForService:serviceString account:serviceUDIDStr error:&error];
        if ([error code] != SSKeychainErrorBadArguments) {
            if (password.length > 0) {
                _UDID = password;
            }
            else
            {
                if (_UDID == nil) {
                    _UDID = [NSUUID UUID].UUIDString;
                }
                [SSKeychain setPassword:_UDID forService:serviceString account:serviceUDIDStr];
            }
        }
        else {
//            DDLogWarn(@"==========Passwordnot found");
        }
    }
    
    return _UDID;
}






@end
