//
//  ZPFLeftView.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/5.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPFLeftView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *shezhiButton;
@end
