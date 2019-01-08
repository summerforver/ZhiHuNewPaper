//
//  ZPFFMDB.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/16.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFFMDB.h"

FMDatabase *db;
@implementation ZPFFMDB


+ (void)querySQLWithPath:(NSString *)pathString {
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pathString];
    
    
    //创建数据库路径
    db = [FMDatabase databaseWithPath:path];
    
    NSLog(@"--path-- %@", path);
    
}

//创建表
+ (void)createTableWithSQLName:(NSString *)sqlName andResultBlock:(void(^)(NSString *result))block {
    NSString *jh;
    if ([db open]) {
        if ([db executeUpdate:sqlName]) {
            jh = @"创建表成功";
        } else {
            jh = @"创建表失败";
        }
        block(jh);
    }
    [db close];
}

/**
 增
 
 @param sqlName 表名
 @param block 回调
 */
+(void)insertSQLWithName:(NSString *)sqlName andResultBlocck:(void(^)(BOOL result))block
{
    BOOL jh;
    
    if ([db open]) {
        if ([db executeUpdate:sqlName]) {
            
            jh = YES;
        }else{
            
            jh = NO;
        }
        
        block(jh);
    }
    [db close];
}


/**
 删
 
 @param sqlName 表名
 @param block 回调
 */
+(void)deleteSQLWithName:(NSString *)sqlName andResultBlock:(void(^)(BOOL result))block
{
    BOOL jh;
    
    if ([db open]) {
        
        if ([db executeUpdate:sqlName]) {
            jh = YES;
        }else{
            jh = NO;
        }
        
        block(jh);
        
    }
    [db close];
    
}


//更新表
+ (void)updateSQLWithName:(NSString *)sqlName andResultBlocck:(void (^)(BOOL))block {
    BOOL jh;
    if ([db open]) {
        if ([db executeUpdate:sqlName]) {
            jh = YES;
        } else {
            jh = NO;
        }
        block(jh);
    }
    [db close];
}

+ (void)searchOneDataWithSQL:(NSString *)sqlName andResultBlock:(void (^)(BOOL, NSDictionary *))block {
    BOOL result = NO;
    if ([db open]) {
        FMResultSet *set = [db executeQuery:sqlName];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([set next]) {
            result = YES;
            [dic setObject:[set stringForColumn:@"images"] forKey:@"images"];
            [dic setObject:[set stringForColumn:@"title"] forKey:@"title"];
            [dic setObject:[set stringForColumn:@"id"] forKey:@"id"];
        }
        block(result, dic);
                                    
    }
    [db close];
    
}

@end
