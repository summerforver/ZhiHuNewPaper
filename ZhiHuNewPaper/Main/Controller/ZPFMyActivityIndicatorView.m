//
//  ZPFMyActivityIndicatorView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/21.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFMyActivityIndicatorView.h"
#define kWidth 375
#define KHeight 667
#define MYCOLOR [UIColor grayColor]

@implementation ZPFMyActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景的大小
        self.frame = CGRectMake(kWidth/2-50, KHeight/2-50, 100, 100);
        // 的背景色
        self.backgroundColor = MYCOLOR;
        self.layer.cornerRadius = 10;
        // 的颜色和格式（白色、白色大、灰色）
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        // 在下面添加文字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 80, 40)];
        label.text = @"loading...";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    }
    return  self;
}


@end
