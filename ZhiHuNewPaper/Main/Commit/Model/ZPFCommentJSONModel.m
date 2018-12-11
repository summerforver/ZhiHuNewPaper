//
//  ZPFCommentJSONModel.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/21.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCommentJSONModel.h"

@implementation ZPFComment_replyJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation ZPFComment_CommentsJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"replyTo":@"reply_to"}];
}

@end

@implementation ZPFCommentJSONModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
