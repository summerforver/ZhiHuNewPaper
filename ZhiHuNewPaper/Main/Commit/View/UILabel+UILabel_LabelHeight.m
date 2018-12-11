//
//  UILabel+UILabel_LabelHeight.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/25.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "UILabel+UILabel_LabelHeight.h"

@implementation UILabel (UILabel_LabelHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 17, width, 0)];
    label.text = title;
    label.font = font;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

@end
