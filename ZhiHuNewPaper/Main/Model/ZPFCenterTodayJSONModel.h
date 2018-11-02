//
//  ZPFCenterTodayJSONModel.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "JSONModel.h"

@interface ZPFCenterTodayStoriesJSONModel : JSONModel
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *title;
@end

@interface ZPFCenterTodayTop_storiesJSONModel : JSONModel
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@end


@interface ZPFCenterTodayJSONModel : JSONModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<ZPFCenterTodayStoriesJSONModel *> *stories;
@property (nonatomic, copy) NSArray<ZPFCenterTodayTop_storiesJSONModel *> *top_stories;
@end
