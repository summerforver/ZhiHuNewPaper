//
//  LHDateScrollerManager.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/29.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHDateScrollerManager : NSObject
/**
 创建数据库和表
 */
- (void)createDataBaseAndTable;
/**
 创建对象
 @return 返回LHDataBaseManager 对象
 */
+ (instancetype)shareManager;
/**
 删除数据
 */
- (void)deleteDataByName:(NSData *)data;
/**
 查询数据
 */
- (NSMutableArray *)selectAllContent;


/**
 更新数据
 */
- (void)updataDataWithName:(NSData *)data;

/**
 新增数据
 */
-(void)insetName:(NSData *)data;
//
//- (void)searchOneDataWithSQL:(NSString *)sqlName andResultBlock:(void (^)(BOOL, NSDictionary *))block;

@end
