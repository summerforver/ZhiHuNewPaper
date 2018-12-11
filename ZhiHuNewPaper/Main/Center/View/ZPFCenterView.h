//
//  ZPFCenterView.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFCenterTodayJSONModel.h"
#import "ZPFScrollerView.h"
#import "ZPFSelectJsonModel.h"

@interface ZPFCenterView : UIView <UITableViewDataSource, ATCarouselViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZPFScrollerView *scrollerView;
@property (nonatomic, strong) ZPFCenterTodayJSONModel *centerTodayJsonModel;
@property (nonatomic, strong) ZPFSelectJsonModel *selectJsonModel;

@property (nonatomic, copy) NSString *headViewDateString;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSMutableArray *mutableArray;

@property int intstring;
@property(nonatomic, assign) NSInteger datas;

- (void)scrollerPictureImage;
//- (void)scrollerPictureTitle;

@end
