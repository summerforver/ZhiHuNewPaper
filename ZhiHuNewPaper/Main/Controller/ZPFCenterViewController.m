//
//  ZPFCenterViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCenterViewController.h"
#import "ZPFMainViewController.h"
#import "ZPFCenterView.h"
#import <Masonry.h>
#import "ZPFCenterTodayJSONModel.h"
#import "ZPFSelectViewController.h"
#import "ZPFCenterModel.h"


@interface ZPFCenterViewController ()<UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation ZPFCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //   标题、背景颜色
    self.title = @"今日新闻";
    self.view.backgroundColor = [UIColor whiteColor];
    //   投影颜色、偏移显示、投影透明度、投影半径
//    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
//    self.navigationController.view.layer.shadowOpacity = 0.15;
//    self.navigationController.view.layer.shadowRadius = 10;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页三条线1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
//    self.navigationItem.title = @"今日新闻";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    self.image = [ZPFCenterViewController createImageWithColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    self.image1 = [ZPFCenterViewController imageByApplyingAlpha:0 image:self.image];
    [self.navigationController.navigationBar setBackgroundImage:self.image1 forBarMetrics:UIBarMetricsDefault];
    
    
    //   菜单按钮的设置
//    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
//    self.navigationItem.leftBarButtonItem = menuItem;
    
    self.centerView = [[ZPFCenterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    self.centerView.tableView.delegate = self;
    
    [self.view addSubview:self.centerView];
    
    self.centerModel = [[ZPFCenterModel alloc] init];
    
    //为view的tableview注册监听指定key的路径
//    [self.centerView addObserver:self forKeyPath:@"tableView" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.centerModel addObserver:self forKeyPath:@"textViewMutableArray" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    
    
}


/**侧边栏的展开和关闭*/
- (void)openCloseMenu: (UIBarButtonItem *)sender {
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}


+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//设置图片透明度

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

////当key路径对应的属性值发生改变时，监听器就会回调自身的监听方法
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    //    NSLog(@"123");
//    [self.centerView.tableView reloadData];
//
//}

//当key路径对应的属性值发生改变时，监听器就会回调自身的监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    
}


- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
//    [self.centerView removeObserver:self forKeyPath:@"tableView" context:nil];
    [self.centerView removeObserver:self forKeyPath:@"tableView" context:nil];
    [self.centerModel removeObserver:self forKeyPath:@"textViewMutableArray" context:nil];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SelectViewController *selectViewController = [[SelectViewController alloc] init];
//    if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            [self.navigationController pushViewController:selectViewController animated:YES];
////            [self presentViewController:selectViewController animated:YES completion:nil];
//        }
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //        220-64
        return 220;
    } else {
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0 || section == 1) {
        return 0.00;
    } else {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor= [UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f];
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setTextAlignment:NSTextAlignmentCenter];
    [header.textLabel setFont:[UIFont systemFontOfSize:14]];
    //    view.tintColor = [UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPFSelectViewController *selectViewController = [[ZPFSelectViewController alloc] init];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self.navigationController pushViewController:selectViewController animated:YES];
    }
    
    
}

//tableView滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    if (scrollView.contentOffset.y < (200.0 + self.centerView.textViewMutableArray.count * 90))
    if (scrollView.contentOffset.y < (200.0 + self.centerModel.textViewMutableArray.count * 90)) {
        self.navigationController.navigationBar.hidden = NO;
        self.image = [ZPFCenterViewController createImageWithColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
        self.image1 = [ZPFCenterViewController imageByApplyingAlpha:scrollView.contentOffset.y/220 image:self.image];
        [self.navigationController.navigationBar setBackgroundImage:self.image1 forBarMetrics:UIBarMetricsDefault];
        
    } else {
        self.navigationController.navigationBar.hidden = YES;
    }
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
