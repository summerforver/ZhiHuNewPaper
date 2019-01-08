//
//  LHDateHeadManager.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/27.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "LHDateHeadManager.h"
#import "FMDB.h"
@interface LHDateHeadManager()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation LHDateHeadManager
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static LHDateHeadManager * dataBaseManager = nil;
    dispatch_once(&onceToken, ^{
        dataBaseManager = [[LHDateHeadManager alloc] init];
    });
    return dataBaseManager;
}


/**
 创建数据库和表
 */
- (void)createDataBaseAndTable {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件名
    NSString * sqlitPath = [path stringByAppendingPathComponent:@"ZPHLHDataHead.sqlite"];
    //    NSLog(@"数据库路径:%@",sqlitPath);
    //创建数据库,加入到队列中
    self.db = [FMDatabase databaseWithPath:sqlitPath];
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE 'user_Image' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' text)"];
        if (result) {
            NSLog(@"user_Image表创建成功");
        } else {
            NSLog(@"user_Image表创建失败");
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
        BOOL result = [self.db executeUpdate:@"insert into 'user_Image'(title) values(?)",title];
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
        BOOL result = [self.db executeUpdate:@"delete from user_Image where title = ?", title];
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
        BOOL result = [self.db executeUpdate:@"update user_Image where title = ?",name];
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
        
        FMResultSet * result = [self.db executeQuery:@"select * from user_Image"];
        
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
