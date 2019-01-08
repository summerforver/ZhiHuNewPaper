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
#import "ZPFExtraCommentJSONModel.h"

// 定位请求返回数据的block
typedef void(^ZPFCenterTodayHandle)(ZPFCenterTodayJSONModel *resultModel);
typedef void(^ZPFSelectTodayHandle)(ZPFSelectJsonModel *selectModel);
typedef void(^ZPFCommentHandle)(ZPFCommentJSONModel *commentModel);
typedef void(^ZPFCommentHandle)(ZPFCommentJSONModel *shortCommentModel);
typedef void(^ZPFExtraCommentHandle)(ZPFExtraCommentJSONModel *extraCommentModel);
// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);


@interface ZPFHttpSessionManager : NSObject

@property (nonatomic, strong) NSMutableArray *titleArray;

+ (instancetype)sharedManager;

// 获取坐标点的信息方法
- (void)fetchCoordinateDataWithsucceed:(ZPFCenterTodayHandle)succeedBlock error:(ErrorHandle)errorBlock;

- (void)fetchCoordinateDataWithPointTime:(NSString *)date succeed:(ZPFSelectTodayHandle)selectSucceedBlock error:(ErrorHandle)errorBlock;

- (void)fetchLongComment:(NSString *)idString succeed:(ZPFCommentHandle)commentSucceedBlock error:(ErrorHandle)errorBlock;

- (void)fetchShortComment:(NSString *)idString succeed:(ZPFCommentHandle)shortCommentSucceedBlock error:(ErrorHandle)errorBlock;

- (void)fetchExtraComment:(NSString *)idString succeed:(ZPFExtraCommentHandle)extraCommentSucceedBlock error:(ErrorHandle)errorBlock;

@end
