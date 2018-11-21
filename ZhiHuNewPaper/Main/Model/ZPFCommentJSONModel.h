//
//  ZPFCommentJSONModel.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/21.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "JSONModel.h"

@protocol ZPFComment_CommentsJSONModel

@end

@interface ZPFComment_CommentsJSONModel : JSONModel

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *likes;

@end

@interface ZPFCommentJSONModel : JSONModel

@property (nonatomic, copy) NSArray<ZPFComment_CommentsJSONModel> *comments;

@end
