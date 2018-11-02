//
//  ZPFOtherViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFOtherViewController.h"
#import "ZPFMainViewController.h"

@interface ZPFOtherViewController ()

@end

@implementation ZPFOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //   标题、背景颜色
    self.title = @"Second";
    self.view.backgroundColor = [UIColor blackColor];
    //   投影颜色、偏移显示、投影透明度、投影半径
    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
    //   菜单按钮的设置
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
}

/**侧边栏的展开和关闭*/
- (void)openCloseMenu: (UIBarButtonItem *)sender
{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
