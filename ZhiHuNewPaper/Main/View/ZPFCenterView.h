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
//@property (nonatomic, strong) ZPFCenterTodayJSONModel *centerTodayJsonModel;
@property (nonatomic, strong) ZPFSelectJsonModel *selectJsonModel;
//@property (nonatomic, strong) NSMutableArray *textViewMutableArray;
//@property (nonatomic, strong) NSMutableArray *pictureImageViewMutableArray;

@property (nonatomic, strong) NSMutableArray *nextTextViewMutableArray;
@property (nonatomic, strong) NSMutableArray *nextPictureImageViewMutableArray;

//@property (nonatomic, strong) NSMutableArray *scrollerViewMutableArray;
@property (nonatomic, copy) NSString *headViewDateString;

@end
