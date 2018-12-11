//
//  ZPFCenterTodayJSONModel.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCenterTodayJSONModel.h"



@implementation ZPFCenterTodayStoriesJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation ZPFCenterTodayTop_storiesJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"zpfImage":@"image", @"zpfTitle":@"title", @"zpfType":@"type", @"zpfId":@"id", @"zpfGaprefix":@"ga_prefix"}];
}
@end

@implementation ZPFCenterTodayJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
