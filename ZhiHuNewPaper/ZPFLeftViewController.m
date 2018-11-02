//
//  ZPFLeftViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFLeftViewController.h"

@interface ZPFLeftViewController ()

@end

@implementation ZPFLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self addLeftItems];
    
}

- (void)addLeftItems {
    
    UIButton *item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    item1.frame = CGRectMake(0, 100, 180, 40);
    item1.backgroundColor = [UIColor orangeColor];
    [item1 setTitle:@"首页" forState:UIControlStateNormal];
    item1.titleLabel.font = [UIFont systemFontOfSize:20];
    item1.tag = 1;
    [self.view addSubview:item1];
    
    UIButton *item2 = [UIButton buttonWithType:UIButtonTypeCustom];
    item2.frame = CGRectMake(0, 140, 180, 40);
    item2.backgroundColor = [UIColor blackColor];
    [item2 setTitle:@"item2" forState:UIControlStateNormal];
    item2.titleLabel.font = [UIFont systemFontOfSize:20];
    item2.tag = 2;
    [self.view addSubview:item2];
    
    
    [item1 addTarget:self action:@selector(leftButtonSelected:) forControlEvents:  UIControlEventTouchUpInside ];
    [item2 addTarget:self action:@selector(leftButtonSelected:) forControlEvents:  UIControlEventTouchUpInside ];
}

- (void)leftButtonSelected:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(leftController:didSelectItemAtIndex:)]) {
        [self.delegate leftController:self didSelectItemAtIndex:sender.tag - 1];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
