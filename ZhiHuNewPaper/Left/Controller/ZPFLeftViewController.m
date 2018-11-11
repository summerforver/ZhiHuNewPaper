//
//  ZPFLeftViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFLeftViewController.h"
#import <Masonry.h>
#import "ZPFLeftView.h"
#import "ZPFCenterViewController.h"

@interface ZPFLeftViewController () <UITableViewDelegate>

@end

@implementation ZPFLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    
    self.leftView = [[ZPFLeftView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

//    self.leftView.tableView.delegate = self;
    
    
    
    
//    [self.leftView.item2 addTarget:self action:@selector(leftButtonSelected:) forControlEvents:  UIControlEventTouchUpInside ];
    
    [self.view addSubview:self.leftView];
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZPFCenterViewController *viewController = [[ZPFCenterViewController alloc] init];
//    if (indexPath.section == 2) {
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
//    
//}

//- (void)leftButtonSelected:(UIButton *)sender {
//    if ([self.delegate respondsToSelector:@selector(leftController:didSelectItemAtIndex:)]) {
//        [self.delegate leftController:self didSelectItemAtIndex:sender.tag - 1];
//
//    }
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
