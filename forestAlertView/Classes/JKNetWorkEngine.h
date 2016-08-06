//
//  JKNetWorkEngine.h
//  Pods
//
//  Created by jianke on 16/6/22.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^JKVoidBlock)(void);
//typedef void (^JKModelBlock)(JKJsonModel* aModelBaseObject);
//typedef void (^JKArrayBlock)(NSArray* listOfModelBaseObjects);
typedef void (^JKDictionaryBlock)(NSMutableDictionary* aDictionary);
typedef void (^JKStringBlock)(NSString *aString);
typedef void (^JKErrorBlock)(NSError* engineError);

@interface JKNetWorkEngine : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
/**
 *发送统计参数的接口
 */
- (NSOperation *)POST:(NSString *)URLString
           Parameters:(id)parameters
                 Body:(NSDictionary *)body
              success:(void (^)(NSOperation *operation,id responseObject))success
              failure:(void (^)(NSOperation *operation,NSError *error))failure;



@end
