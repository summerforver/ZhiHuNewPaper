//
//  ZPFShareView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/11.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFShareView.h"
#import <Masonry.h>
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height
//#define K_marginHeight 10
#define K_marginWidth 20



@implementation ZPFShareView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView {
//    [super layoutSubviews];
    
    self.shareButton = [[UIButton alloc] init];
    self.shareButton.backgroundColor = [UIColor whiteColor];
    [self.shareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.shareButton setTitle:@"收藏" forState:UIControlStateNormal];
    self.shareButton.selected = NO;
    [self addSubview:self.shareButton];

    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(K_marginWidth);
        make.top.mas_equalTo(self).offset(190.0);
        make.width.mas_equalTo(335.0);
        make.height.mas_equalTo(50.0);
    }];
    
    self.deleteButton = [[UIButton alloc] init];
    self.deleteButton.backgroundColor = [UIColor whiteColor];
    [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.deleteButton setTitle:@"取消" forState:UIControlStateNormal];
    self.deleteButton.selected = NO;
    
    [self addSubview:self.deleteButton];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareButton.mas_left);
        make.top.mas_equalTo(self.shareButton.mas_bottom).offset(K_marginWidth);
        make.width.mas_equalTo(self.shareButton.mas_width);
        make.height.mas_equalTo(self.shareButton.mas_height);
    }];
    
//    [self.deleteButton addTarget:self action:@selector(pressDeleteButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.shareButton addTarget:self action:@selector(pressShareButton) forControlEvents:UIControlEventTouchUpInside];
//
}

//- (void)pressDeleteButton {
//    
//    [self removeFromSuperview];
//}
//
//- (void)pressShareButton {
//    
//    NSLog(@"123");
//    
//}




@end
