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
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *dataWithImageArray;
@property (nonatomic, strong) NSMutableArray *imageStringArray;
@property (nonatomic, strong) NSMutableArray *titleMutableArray;

@property (nonatomic, strong) NSMutableArray *mutableArray;
//@property (nonatomic, strong) NSArray *headImageArray;
@property int intstring;
@property int count;
@property(nonatomic, assign) NSInteger datas;

@property int isInternet;

- (void)scrollerPictureImage;
//- (void)scrollerPictureTitle;

@end
