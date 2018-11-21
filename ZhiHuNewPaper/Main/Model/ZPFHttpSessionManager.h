//
//  ZPFHttpSessionManager.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/9.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPFCenterTodayJSONModel.h"
#import "ZPFSelectJsonModel.h"
#import "ZPFCommentJSONModel.h"

// 定位请求返回数据的block
typedef void(^ZPFCenterTodayHandle)(ZPFCenterTodayJSONModel *resultModel);
typedef void(^ZPFSelectTodayHandle)(ZPFSelectJsonModel *selectModel);
typedef void(^ZPFCommentHandle)(ZPFCommentJSONModel *commentModel);

// 获取周边point的回调block
//typedef void(^MAPGetPointHandle)(ZPFCenterTodayJSONModel *pointModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

@interface ZPFHttpSessionManager : NSObject


+ (instancetype)sharedManager;

// 获取坐标点的信息方法
- (void)fetchCoordinateDataWithsucceed:(ZPFCenterTodayHandle)succeedBlock error:(ErrorHandle)errorBlock;

- (void)fetchCoordinateDataWithPointTime:(NSString *)date succeed:(ZPFSelectTodayHandle)selectSucceedBlock error:(ErrorHandle)errorBlock;

- (void)fetchLongComment:(NSString *)idString succeed:(ZPFCommentHandle)commentSucceedBlock error:(ErrorHandle)errorBlock;

@end
