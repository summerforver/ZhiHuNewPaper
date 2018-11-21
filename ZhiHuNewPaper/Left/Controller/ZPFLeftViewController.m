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
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@interface ZPFLeftViewController () <UITableViewDelegate>

@end

@implementation ZPFLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    
//    self.leftView = [[ZPFLeftView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    self.leftView = [[ZPFLeftView alloc] initWithFrame:CGRectMake(0, 0, 220.0 / 375.0 * ZPFWidth, ZPFHeight)];

    self.leftView.tableView.delegate = self;
    
    
    
    
//    [self.leftView.item2 addTarget:self action:@selector(leftButtonSelected:) forControlEvents:  UIControlEventTouchUpInside ];
    
    [self.view addSubview:self.leftView];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70.0/667 * ZPFHeight;
    } else if (indexPath.section == 1) {
        return 50.0/667 * ZPFHeight;
    } else {
        return 50.0/667 * ZPFHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
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
