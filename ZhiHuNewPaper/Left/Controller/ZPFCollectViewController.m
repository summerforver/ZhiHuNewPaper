//
//  ZPFCollectViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCollectViewController.h"
#import "ZPFNewsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFSelectViewController.h"
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@interface ZPFCollectViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZPFCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationItem.title = @"收藏";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
////
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
//
//    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zuobian"] style:UIBarButtonItemStylePlain target:self action:@selector(pressButton)];


    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, 64)];
    headView.backgroundColor = [UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZPFWidth/2 - 20, 20, 40, 40)];
    label.text = @"收藏";
    label.font = [UIFont systemFontOfSize:18.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];

    [button setImage:[UIImage imageNamed:@"zuobian"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];

    [headView addSubview:button];
    [self.view addSubview:headView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ZPFWidth, ZPFHeight - 64) style:UITableViewStylePlain];
    [self.tableView registerClass:[ZPFNewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pass2:) name:@"pass2" object:nil];
    
}

- (void)pass2:(NSNotification *)text {
    
    NSLog(@"123");
    
    self.IDString = text.userInfo[@"string2"];
    self.TitleString = text.userInfo[@"title"];
    self.ImageString = text.userInfo[@"image"];
    
    [self.titleMutableArray addObject:self.TitleString];
    [self.imageMutableArray addObject:self.ImageString];
    
    //    [self.tableView reloadData];
    //
//    NSLog(@"121212 %@", self.IDString);
//    NSLog(@"121212 %@", self.TitleString);
//    NSLog(@"121212 %@", self.ImageString);
//    
}


- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
//    return self.titleMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPFNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
    cell.label.text = self.TitleString;
    
//    cell.label.text = self.titleMutableArray[indexPath.section];
   
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.ImageString]];
//    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.imageMutableArray[indexPath.section]]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ZPFSelectViewController *selectController = [[ZPFSelectViewController alloc] init];
//        [self.navigationController pushViewController:selectController animated:YES];
        selectController.stringID = self.IDString;
        [self presentViewController:selectController animated:YES completion:nil];
    }
    
}



- (void)pressButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
