//
//  JKNetWorkEngine+JKAnalytics.m
//  Pods
//
//  Created by jianke on 16/6/22.
//
//

#import "JKNetWorkEngine+JKAnalytics.h"
#import <AFNetworking/AFNetworking.h>
//#import "JKCodeModel.h"


@implementation JKNetWorkEngine (Parameter)


-(NSOperation *)dispatchParameteron:(id)parameters
                          Succeeded:(JKDictionaryBlock)succeededBlock
                            onError:(JKErrorBlock)errorBlock{
    return [self POST:@"" Parameters:parameters Body:nil success:^(NSOperation *operation, id responseObject) {
        
        if (succeededBlock) succeededBlock(responseObject);
        
    } failure:^(NSOperation *operation, NSError *error) {
        if (errorBlock) errorBlock(error);
    }];
    
}

@end

