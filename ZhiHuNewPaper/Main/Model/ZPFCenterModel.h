//
//  ZPFCenterModel.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPFCenterTodayJSONModel.h"

@interface ZPFCenterModel : NSObject
@property (nonatomic, strong) ZPFCenterTodayJSONModel *centerTodayJsonModel;
@property (nonatomic, strong) NSMutableArray *textViewMutableArray;
@property (nonatomic, strong) NSMutableArray *pictureImageViewMutableArray;

@property (nonatomic, strong) NSMutableArray *scrollerViewMutableArray;
@property (nonatomic, copy) NSString *headViewDateString;
@end
