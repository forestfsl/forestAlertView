//
//  JKAnaliseDatabase.m
//  Pods
//
//  Created by jianke on 16/6/22.
//
//

#import "JKAnaliseDatabase.h"
#import <FMDB/FMDB.h>
#import "JKAnalisParaModel.h"
#import "JKJsonHelp.h"
#import <libkern/OSAtomic.h>

//大数据分析参数记录表
#define CREATE_JKAnaliseParameterTable @"CREATE TABLE if not exists JKAnaliseParameterTable  (id integer PRIMARY KEY AUTOINCREMENT,UserId text,UserFlag text,pageId text,Referrer text,Timestamp text,eventId text,duration text,extras text,params text)"
#define INSERT_JKAnaliseParameterTable @"INSERT INTO JKAnaliseParameterTable(UserId,UserFlag,pageId,Referrer,Timestamp,eventId,duration,extras,params) values(?,?,?,?,?,?,?,?,?)"


@implementation JKAnaliseDatabase

{
    FMDatabase *fmDataBase;
    NSString *dataPath;
}

static JKAnaliseDatabase *JKAnaliseParamDatabase = nil;


- (id)init
{
    self = [super init];
    if (self) {
        dataPath = [self getDataBase];
        [self createDataBase];
        [self createTable];
    }
    return self;
}


#pragma mark --单例构造方法
+ (JKAnaliseDatabase *)sharedDatabase{
    
    if (JKAnaliseParamDatabase == nil) {
        JKAnaliseParamDatabase = [[JKAnaliseDatabase alloc] init];
    }
    return JKAnaliseParamDatabase;
}

#pragma mark ---释放单例
- (void)releaseAnaliseDatabase
{
    JKAnaliseParamDatabase = nil;
    
}

#pragma mark ---删除表格
-(void)deletable:(NSString *)tableName{
    //打开数据库
    if (![fmDataBase open]) {
//        DDLogDebug(@"数据库打开失败");
        return ;
    }
    //为数据库设置缓存，提高查询效率
    [fmDataBase setShouldCacheStatements:YES];
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    if (![fmDataBase executeUpdate:sqlstr])
    {
//        DDLogDebug(@"Delete table error!");
    }
    
    [fmDataBase close];
}

#pragma mark --数据库路径

- (NSString *)getDataBase{
    //重新创建db文件
    NSString *shopingCarModels = [NSString stringWithFormat:@"JKAnaliseParameterTable.db"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:shopingCarModels];
}

#pragma mark --创建数据库

- (void)createDataBase{
    fmDataBase = [FMDatabase databaseWithPath:dataPath];
}

#pragma mark --创建表单

- (void)createTable{
    if (!fmDataBase) {
        [self createDataBase];
    }
    //打开数据库
    if (![fmDataBase open]) {
//        DDLogDebug(@"数据库打开失败");
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [fmDataBase setShouldCacheStatements:YES];
    
    BOOL isCreateOK;
    isCreateOK = [fmDataBase executeUpdate:CREATE_JKAnaliseParameterTable];
    if (!isCreateOK) {
//        DDLogDebug(@"创建用户记录表失败:%@",[fmDataBase lastError]);
    }else
    {
//        DDLogDebug(@"创建用户记录表成功");
    }
    [fmDataBase close];
}

#pragma mark----根据最大id来获取小于等于最大id的所有元素

- (NSMutableArray *)seleteAllAnalisParaModelDataToMaxid:(int)maxid{
    
    if (!fmDataBase) {
        [self createDataBase];
    }
    
    //打开数据库
    if (![fmDataBase open]) {
        //        DDLogDebug(@"数据库打开失败");
        return nil;
    }
    //为数据库设置缓存，提高查询效率
    [fmDataBase setShouldCacheStatements:YES];
    
    if (![fmDataBase tableExists:@"JKAnaliseParameterTable"]) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *set = [fmDataBase executeQuery:@"select * from JKAnaliseParameterTable where id <= ?",[NSString stringWithFormat:@"%d",maxid]];
    while ([set next]) {
        //这个地方要改，改成不是模型的，用一个字典来保存
        NSDictionary *dic = [NSDictionary dictionary];
        NSString *UserId = [set stringForColumn:@"UserId"];
        NSString *UserFlag = [set stringForColumn:@"UserFlag"];
        NSString *pageId = [set stringForColumn:@"pageId"];
        NSString *Referrer = [set stringForColumn:@"Referrer"];
        NSString *Timestamp = [set stringForColumn:@"Timestamp"];
        NSString *eventId = [set stringForColumn:@"eventId"];
        NSString *duration = [set stringForColumn:@"duration"];
        NSString *extras = [JKJsonHelp toJsonObject:[set stringForColumn:@"extras"]];
        NSString *params = [JKJsonHelp toJsonObject:[set stringForColumn:@"params"]];
        dic = @{
                @"UserId" : UserId ? UserId : @"0",
                @"UserFlag" : UserFlag ? UserFlag : @"0",
                @"pageId" : pageId ? pageId : @"0",
                @"Referrer" : Referrer ? Referrer : @"0",
                @"Timestamp" : Timestamp ? Timestamp : @"0",
                @"eventId" : eventId ? eventId : @"0",
                @"duration" : duration ? duration : @"0",
                @"extras" : extras ? extras : @"0",
                @"params" : params ? params : @"0"
                };
        [array addObject:dic];
    }
    
    [fmDataBase close];
    return array;
}

#pragma mark根据最大id来删除小于等于最大id的所有元素

- (void)deleteData:(int)maxid{
    
    if (!fmDataBase) {
        [self createDataBase];
    }
    
    //打开数据库
    if (![fmDataBase open]) {
        //        DDLogDebug(@"数据库打开失败");
        return;
    }
    //为数据库设置缓存，提高查询效率
    [fmDataBase setShouldCacheStatements:YES];
    
    if (![fmDataBase tableExists:@"JKAnaliseParameterTable"]) {
        return;
    }
    BOOL delete_record = [fmDataBase executeUpdate:@"delete from JKAnaliseParameterTable where JKAnaliseParameterTable.id <= ?",[NSString stringWithFormat:@"%d",maxid]];
    if (!delete_record) {
//        DDLogDebug(@"删除用户数据失败");
    }else{
//        DDLogDebug(@"删除用户数据成功");
    }
    [fmDataBase close];
}


-(void)saveData:(JKAnalisParaModel *)AnalisParaModel{
    
    //搞一个模型来保存这个参数，这个模型的赋值是在event方法里面实现
    
    if (!fmDataBase) {
        [self createDataBase];
    }
    
    //打开数据库
    if (![fmDataBase open]) {
//        DDLogDebug(@"数据库打开失败");
        return;
    }
    //为数据库设置缓存，提高查询效率
    [fmDataBase setShouldCacheStatements:YES];
    
    if (![fmDataBase tableExists:@"JKAnaliseParameterTable"]) {
        return;
    }
    
    BOOL isInsert = [fmDataBase executeUpdate:INSERT_JKAnaliseParameterTable,AnalisParaModel.UserId,AnalisParaModel.UserFlag,AnalisParaModel.pageId,AnalisParaModel.Referrer,AnalisParaModel.Timestamp,AnalisParaModel.eventId,AnalisParaModel.duration,AnalisParaModel.extras,AnalisParaModel.param];
    if (!isInsert) {
//        DDLogDebug(@"插入用户记录数据失败:%@",[fmDataBase lastError]);
    }else
    {
//        DDLogDebug(@"插入用户记录数据成功");
    }
    [fmDataBase close];
    
}

//获取最大id
- (int)getMaxId{
    int maxId = 0;
    if (!fmDataBase) {
        [self createDataBase];
    }
    if (![fmDataBase open]) {
        return 0;
    }
    [fmDataBase setShouldCacheStatements:YES];
    if (![fmDataBase tableExists:@"JKAnaliseParameterTable"]) {
        return 0;
    }
    
    FMResultSet *set = [fmDataBase executeQuery:@"select max(id) as id from JKAnaliseParameterTable" ];
    while ([set next]) {
        
        maxId = [[set stringForColumn:@"Id"] intValue];
    }
    
    [fmDataBase close];
    
    return maxId;
    
}
@end
