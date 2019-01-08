//
//  LHDateScrollerManager.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/29.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "LHDateScrollerManager.h"
#import "FMDB.h"
@interface LHDateScrollerManager()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation LHDateScrollerManager
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static LHDateScrollerManager * dataBaseManager = nil;
    dispatch_once(&onceToken, ^{
        dataBaseManager = [[LHDateScrollerManager alloc] init];
    });
    return dataBaseManager;
}


/**
 创建数据库和表
 */
- (void)createDataBaseAndTable {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件名
    NSString * sqlitPath = [path stringByAppendingPathComponent:@"ZPFLHDateScroll.sqlite"];
    //    NSLog(@"数据库路径:%@",sqlitPath);
    //创建数据库,加入到队列中
    self.db = [FMDatabase databaseWithPath:sqlitPath];
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE 'user_Headimage' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'imageData' BLOB)"];
        if (result) {
            NSLog(@"user_HeadImage表创建成功");
        } else {
            NSLog(@"user_HeadImage表创建失败");
        }
    } else {
        NSLog(@"数据库打开失败");
    }
    [self.db close];
}


/**
 新增数据
 */
-(void)insetName:(NSData *)data {
    
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"insert into 'user_Headimage'(imageData) values(?)",data];
        if (result) {
            NSLog(@"新增数据成功 data：%@",data);
        } else {
            NSLog(@"新增数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
    [self.db close];
}



/**
 删除数据
 */
- (void)deleteDataByName:(NSData *)data {
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from user_Headimage where imageData = ?", data];
        if (result) {
            NSLog(@"删除数据成功");
        }
        else{
            NSLog(@"删除数据失败");
        }
    } else {
        NSLog(@"数据库打开失败");
    }
    [self.db close];
}


/**
 更新数据
 */
- (void)updataDataWithName:(NSData *)data {
    
    
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"update user_Headimage where imageData = ?",data];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
    
    [self.db close];
}



/**
 查询数据
 */
- (NSMutableArray *)selectAllContent {
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if ([self.db open]) {
        
        FMResultSet * result = [self.db executeQuery:@"select * from user_Headimage"];
        
        while ([result next]) {
            
//            NSData *data = [result stringForColumn:@"imageData"];
            NSData *data = [result dataForColumn:@"imageData"];
            //            NSLog(@"-=-=-=- %@", title);
            //先将数据存放到字典
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setObject:[result stringForColumn:@"imageData"] forKey:@"imageData"];
            //然后将字典存放到数组
            //            [array addObject:dic];
            
            [array addObject:data];
        }
    } else {
        NSLog(@"打开数据库失败");
    }
    [self.db close];
    
    return array;
}


@end
