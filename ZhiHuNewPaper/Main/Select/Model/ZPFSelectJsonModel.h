//
//  ZPFSelectJsonModel.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "JSONModel.h"

@protocol ZPFSelectStoriesJsonModel

@end

@interface ZPFSelectStoriesJsonModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *id;
@end

@interface ZPFSelectJsonModel : JSONModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<ZPFSelectStoriesJsonModel> *stories;
@end
