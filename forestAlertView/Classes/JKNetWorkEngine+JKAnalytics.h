//
//  JKNetWorkEngine+JKAnalytics.h
//  Pods
//
//  Created by jianke on 16/6/22.
//
//

#import "JKNetWorkEngine.h"

@interface JKNetWorkEngine (Parameter)

/**
 * 发送统计参数的接口
 */

-(NSOperation *)dispatchParameteron:(id)parameters
                          Succeeded:(JKDictionaryBlock)succeededBlock
                            onError:(JKErrorBlock)errorBlock;

@end

