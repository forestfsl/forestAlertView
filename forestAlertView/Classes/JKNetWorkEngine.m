//
//  JKNetWorkEngine.m
//  Pods
//
//  Created by jianke on 16/6/22.
//
//

#import "JKNetWorkEngine.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation JKNetWorkEngine

- (NSOperation *)POST:(NSString *)URLString
           Parameters:(id)parameters
                 Body:(NSDictionary *)body
              success:(void (^)(NSOperation *, id))success
              failure:(void (^)(NSOperation *, NSError *error))failure{
    return [self.manager POST:@"bigeater/appcontrail" parameters:parameters success:
            ^(AFHTTPRequestOperation *operation, id responseObject) {
                

                    if (success) success(operation, responseObject);
                
            } failure:
            ^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
    
}

- (AFHTTPRequestOperationManager *)manager{
    if (_manager == nil) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://172.17.250.104/"]];
        _manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    }
    return _manager;
}

@end
