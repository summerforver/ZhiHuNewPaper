//
//  LHDataBaseManager.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/17.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "LHDataBaseManager.h"

#import "FMDB.h"
@interface LHDataBaseManager()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation LHDataBaseManager
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static LHDataBaseManager * dataBaseManager = nil;
    dispatch_once(&onceToken, ^{
        dataBaseManager = [[LHDataBaseManager alloc] init];
    });
    return dataBaseManager;
}


/**
 创建数据库和表
 */
- (void)createDataBaseAndTable {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件名
    NSString * sqlitPath = [path stringByAppendingPathComponent:@"ZPHLHDataBase.sqlite"];
//    NSLog(@"数据库路径:%@",sqlitPath);
    //创建数据库,加入到队列中
     self.db = [FMDatabase databaseWithPath:sqlitPath];
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE 'user_title' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' text)"];
        if (result) {
            NSLog(@"user_title表创建成功");
        } else {
            NSLog(@"user_title表创建失败");
        }
    } else {
        NSLog(@"数据库打开失败");
    }
    [self.db close];
}


/**
 新增数据
 */
-(void)insetName:(NSString *)title {
    
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"insert into 'user_title'(title) values(?)",title];
        if (result) {
            NSLog(@"新增数据成功 title：%@",title);
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
- (void)deleteDataByName:(NSString *)title {
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from user_title where title = ?", title];
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
 @param name 更新的名字
 */
- (void)updataDataWithName:(NSString *)name {
    
    
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"update user_title where title = ?",name];
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
        
        FMResultSet * result = [self.db executeQuery:@"select * from user_title"];
        
        while ([result next]) {
            
            NSString *title = [result stringForColumn:@"title"];
//            NSLog(@"-=-=-=- %@", title);
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[result stringForColumn:@"title"] forKey:@"title"];
            //然后将字典存放到数组
//            [array addObject:dic];
            
            [array addObject:title];
        }
    } else {
        NSLog(@"打开数据库失败");
    }
    [self.db close];
    
    return array;
    
    
    
    
}

//- (void)searchOneDataWithSQL:(NSString *)sqlName andResultBlock:(void (^)(BOOL, NSDictionary *))block {
//    BOOL result = NO;
//    if ([self.db open]) {
//        FMResultSet *set = [self.db executeQuery:sqlName];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        if ([set next]) {
//            result = YES;
//            [dic setObject:[set stringForColumn:@"title"] forKey:@"title"];
//        }
//        block(result, dic);
//        
//    } else {
//        NSLog(@"打开数据库失败");
//    }
//    [self.db close];
//    
//}

@end
