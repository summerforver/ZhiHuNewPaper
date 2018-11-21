//
//  ZPFCommentView.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/21.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFCommentJSONModel.h"

@interface ZPFCommentView : UIView <UITableViewDataSource>

@property (nonatomic, strong) UIView  *footView1;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZPFCommentJSONModel *longCommentModel;
@property (nonatomic, strong) NSMutableArray *array;

@end
