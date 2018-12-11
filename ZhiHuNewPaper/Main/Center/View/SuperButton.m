//
//  SuperButton.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/8.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "SuperButton.h"

#define K_width 15
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height


@implementation SuperButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(K_width, contentRect.size.height * 0.7, ZPFWidth - K_width, 50);
}


@end
