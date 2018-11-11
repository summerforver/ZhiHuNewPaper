//
//  ZPFHttpSessionManager.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/9.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPFCenterTodayJSONModel.h"

// 定位请求返回数据的block
typedef void(^ZPFCenterTodayHandle)(ZPFCenterTodayJSONModel *resultModel);

// 获取周边point的回调block
//typedef void(^MAPGetPointHandle)(ZPFCenterTodayJSONModel *pointModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

@interface ZPFHttpSessionManager : NSObject


+ (instancetype)sharedManager;

// 获取坐标点的信息方法
- (void)fetchCoordinateDataWithPointID:(int)id succeed:(ZPFCenterTodayHandle)succeedBlock error:(ErrorHandle)errorBlock;

// 获取周围坐标的方法
//- (void)fetchPointWithLongitude:(double)longitude Latitude:(double)latitude Range:(int)range succeed:(MAPGetPointHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end
