//
//  ZPFCenterTodayJSONModel.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "JSONModel.h"

@protocol ZPFCenterTodayStoriesJSONModel

@end

@protocol ZPFCenterTodayTop_storiesJSONModel

@end


@interface ZPFCenterTodayStoriesJSONModel : JSONModel
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;
@end

@interface ZPFCenterTodayTop_storiesJSONModel : JSONModel
@property (nonatomic, copy) NSString *zpfImage;
@property (nonatomic, copy) NSString *zpfTitle;
@property (nonatomic, copy) NSString *zpfType;
@property (nonatomic, copy) NSString *zpfId;
@property (nonatomic, copy) NSString *zpfGaprefix;
@end


@interface ZPFCenterTodayJSONModel : JSONModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<ZPFCenterTodayStoriesJSONModel> *stories;
@property (nonatomic, copy) NSArray<ZPFCenterTodayTop_storiesJSONModel> *top_stories;
@end
