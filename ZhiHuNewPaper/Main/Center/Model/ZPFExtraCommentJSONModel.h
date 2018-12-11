//
//  ZPFExtraCommentJSONModel.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/25.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "JSONModel.h"
@protocol ZPFExtraCommentJSONModel

@end

@interface ZPFExtraCommentJSONModel : JSONModel

@property (nonatomic, copy) NSString *long_comments;
@property (nonatomic, copy) NSString *popularity;
@property (nonatomic, copy) NSString *short_comments;
@property (nonatomic, copy) NSString *comments;

@end
