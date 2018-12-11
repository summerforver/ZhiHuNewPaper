//
//  UILabel+UILabel_LabelHeight.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/25.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabel_LabelHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;

@end
