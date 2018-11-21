
//
//  ZPFFooterView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/11.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFFooterView.h"
#import <Masonry.h>
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height


@implementation ZPFFooterView

- (instancetype) init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView {
    
    
    self.timeButton = [[UIButton alloc] init];
    [self.timeButton setImage:[UIImage imageNamed:@"lixian"] forState:UIControlStateNormal];
    [self addSubview:self.timeButton];
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0/375.0 * ZPFWidth);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"离线";
    self.timeLabel.textColor = [UIColor colorWithRed:0.53f green:0.55f blue:0.56f alpha:1.00f];;
    self.timeLabel.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50.0/375.0 * ZPFWidth);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(25);
    }];
    
    self.nightButton = [[UIButton alloc] init];
    [self.nightButton setImage:[UIImage imageNamed:@"yejianmoshi "] forState:UIControlStateNormal];
    [self addSubview:self.nightButton];
    [self.nightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120.0/375.0 * ZPFWidth);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    self.nightLabel = [[UILabel alloc] init];
    self.nightLabel.text = @"夜间";
    self.nightLabel.textColor = [UIColor colorWithRed:0.53f green:0.55f blue:0.56f alpha:1.00f];;
    self.nightLabel.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:self.nightLabel];
    [self.nightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(150.0/375.0 * ZPFWidth);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(25);
    }];
    
    
    
}


@end
