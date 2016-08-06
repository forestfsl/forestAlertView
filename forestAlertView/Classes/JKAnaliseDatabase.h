//
//  JKAnaliseDatabase.h
//  Pods
//
//  Created by jianke on 16/6/22.
//
//

#import <Foundation/Foundation.h>
#import "JKAnalisParaModel.h"
@interface JKAnaliseDatabase : NSObject

/**
 * sharedDatabase单利
 */
+ (JKAnaliseDatabase *)sharedDatabase;

/**
 * 删除表单
 */
-(void)deletable:(NSString *)tableName;

/**
 * 释放单利
 */
- (void)releaseAnaliseDatabase;

/**
 * 选择小于等于最大id的所有数据
 */
- (NSMutableArray *)seleteAllAnalisParaModelDataToMaxid:(int)maxid;

/**
 * 调用此方法，保存数据到表单
 */
-(void)saveData:(JKAnalisParaModel *)AnalisParaModel;

/**
 * 获取表单中，最大的id
 */
- (int)getMaxId;

/**
 * 删除小于等于最大id的所有元素
 */
- (void)deleteData:(int)maxid;

@end
