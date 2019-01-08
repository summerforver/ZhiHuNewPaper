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
#import "ZPFNewsTableViewCell.h"
#import "ZPFScrollerTableViewCell.h"
#import "JSONModel.h"
#import "ZPFScrollerView.h"
#import "ZPFSelectJsonModel.h"
#import "ZPFHttpSessionManager.h"
#import "ZPFDataUtils.h"
#import "ZPFFMDB.h"
#import "LHDataBaseManager.h"
#import "LHDateHeadManager.h"
#import "LHDateScrollerManager.h"

#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height


@interface ZPFCenterViewController ()<UITableViewDelegate, UIScrollViewDelegate, ATCarouselViewDelegate>

@end

@implementation ZPFCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.days = -1;
    //   标题、背景颜色
    self.title = @"今日新闻";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页三条线1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
//    self.navigationItem.title = @"今日新闻";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    self.image = [ZPFCenterViewController createImageWithColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    self.image1 = [ZPFCenterViewController imageByApplyingAlpha:0 image:self.image];
    [self.navigationController.navigationBar setBackgroundImage:self.image1 forBarMetrics:UIBarMetricsDefault];
    //   菜单按钮的设置
//    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
//    self.navigationItem.leftBarButtonItem = menuItem;
    
    self.centerView = [[ZPFCenterView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, ZPFHeight)];
    
    self.centerView.tableView.delegate = self;
    
    
    [self.view addSubview:self.centerView];
//    self.centerModel = [[ZPFCenterModel alloc] init];
//    为view的tableview注册监听指定key的路径
    [self.centerView addObserver:self forKeyPath:@"tableView" options:NSKeyValueObservingOptionNew context:nil];
//    [self.centerModel addObserver:self forKeyPath:@"pictureImageViewMutableArray" options:NSKeyValueObservingOptionNew context:nil];
    
   
    
    self.mutableArray = [[NSMutableArray alloc] init];
    self.centerView.array = self.mutableArray;

    self.isLoading = NO;
    
    self.centerView.intstring = self.intString;
    
//    self.centerView.isInternet = self.Internet;
    
    self.centerView.datas = self.days;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pass:) name:@"pass" object:nil];
    [[LHDataBaseManager shareManager] createDataBaseAndTable];
    [[LHDateHeadManager shareManager] createDataBaseAndTable];
    [[LHDateScrollerManager shareManager] createDataBaseAndTable];
}

- (void)refresh:(id)sender{
    
}

- (void)pass:(NSNotification *)text {
    self.string = text.userInfo[@"string"];
    self.stringTitle = text.userInfo[@"titleString"];
    self.stringImage = text.userInfo[@"imageString"];
//    
//    NSLog(@"=====%@", self.string);
//    NSLog(@"=====%@", self.stringTitle);
//    NSLog(@"=====%@", self.stringImage);
}

/**
 视图即将出现
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateAnnotationArray];
    
    if (self.centerView.tableView.contentOffset.y < (220 + self.centerView.centerTodayJsonModel.stories.count * 90) ) {
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];

        [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];

        [self setStatusBarBackgroundColor:[UIColor clearColor]];
    } else {

        [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    }
}


- (void)updateAnnotationArray {
        [[ZPFHttpSessionManager sharedManager] fetchCoordinateDataWithsucceed:^(ZPFCenterTodayJSONModel *resultModel) {
            self.centerView.centerTodayJsonModel = resultModel;
            [self.mutableArray addObject:resultModel];
            
            self.centerView.isInternet = 1;
            
            for (int i = 0; i < self.centerView.centerTodayJsonModel.stories.count; i ++) {
                NSString *string1 = [self.centerView.centerTodayJsonModel.stories[i] title];
                [[LHDataBaseManager shareManager] deleteDataByName:string1];
            }
            
            for (int i = 0; i < self.centerView.centerTodayJsonModel.stories.count; i ++) {
                NSString *string1 = [self.centerView.centerTodayJsonModel.stories[i] title];
                [[LHDataBaseManager shareManager] insetName:string1];
                
            }
            for (int i = 0; i < self.centerView.centerTodayJsonModel.stories.count; i ++) {
                NSArray *array = [self.centerView.centerTodayJsonModel.stories[i] images];
                NSString *string = [array componentsJoinedByString:@","];
                [[LHDateHeadManager shareManager] deleteDataByName:string];
            }
            
            for (int i = 0; i < self.centerView.centerTodayJsonModel.stories.count; i ++) {
                NSArray *array = [self.centerView.centerTodayJsonModel.stories[i] images];
                NSString *string = [array componentsJoinedByString:@","];
                [[LHDateHeadManager shareManager] insetName:string];
                
            }
            
            for (int i = 0; i < self.centerView.centerTodayJsonModel.top_stories.count; i ++) {
                NSString *string = [self.centerView.centerTodayJsonModel.top_stories[i] zpfImage];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
                [[LHDateScrollerManager shareManager] deleteDataByName:data];
            }
            
            for (int i = 0; i < self.centerView.centerTodayJsonModel.top_stories.count; i ++) {
                NSString *string = [self.centerView.centerTodayJsonModel.top_stories[i] zpfImage];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
                [[LHDateScrollerManager shareManager] insetName:data];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.centerView.tableView reloadData];
                [self.centerView scrollerPictureImage];
            });
        } error:^(NSError *error) {
//            NSLog(@"error:%@", error);
            self.centerView.isInternet = 0;
            self.centerView.titleArray = [[LHDataBaseManager shareManager] selectAllContent];
            self.centerView.imageStringArray = [[LHDateHeadManager shareManager] selectAllContent];
            self.centerView.imageArray = [[LHDateScrollerManager shareManager] selectAllContent];
            self.centerView.count ++;
        dispatch_async(dispatch_get_main_queue(), ^{
                [self.centerView.tableView reloadData];
                [self.centerView scrollerPictureImage];
            });
        }];
}




- (void)updateAnnotationArray1 {
    self.isLoading = YES;

    [[ZPFHttpSessionManager sharedManager] fetchCoordinateDataWithPointTime:[ZPFDataUtils dateStringBeforeDays:self.days + 1] succeed:^(ZPFSelectJsonModel *selectModel) {
        self.centerView.selectJsonModel = selectModel;
        
//        NSLog(@"%@", selectModel.date);
        
        [self.mutableArray addObject:selectModel];
        self.centerView.isInternet = 1;
        
       
        
        for (int i = 0; i < self.centerView.selectJsonModel.stories.count; i ++) {
            NSString *string1 = [self.centerView.selectJsonModel.stories[i] title];
//            NSArray *array = [self.centerView.selectJsonModel.stories[i] images];
//            NSString *string = [array componentsJoinedByString:@","];
            [[LHDataBaseManager shareManager] deleteDataByName:string1];
        }
        
        for (int i = 0; i < self.centerView.selectJsonModel.stories.count; i ++) {
            NSString *string1 = [self.centerView.selectJsonModel.stories[i] title];
//            NSArray *array = [self.centerView.selectJsonModel.stories[i] images];
//            NSString *string = [array componentsJoinedByString:@","];
            [[LHDataBaseManager shareManager] insetName:string1];
            
        }
//
//        NSMutableArray *array1 = [[NSMutableArray alloc] init];
//        [array1 addObject:selectModel];
//
//
//        [self.mutableArray addObject:array1];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.centerView.tableView reloadData];
        });
        self.isLoading = NO;
        self.days --;
    } error:^(NSError *error) {
//        NSLog(@"error:%@", error);
        self.isLoading = NO;
        
        self.centerView.isInternet = 0;
        self.centerView.titleMutableArray = [[LHDataBaseManager shareManager] selectAllContent];
//        [self.mutableArray addObject:self.centerView.titleMutableArray];
        self.centerView.count ++;
        NSLog(@"===%@",self.centerView.titleMutableArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.centerView.tableView reloadData];
        });
    }];

    

}

/**侧边栏的展开和关闭*/
- (void)openCloseMenu: (UIBarButtonItem *)sender {
    NSLog(@"123");
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
    
//    NSDictionary *dic = @{@"string1": self.string, @"titleString": self.stringTitle, @"imageString": self.stringImage};
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pass1" object:nil userInfo:dic];
    

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
    NSLog(@"123");
    NSLog(@"===%@", change);
    
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    [self.centerView removeObserver:self forKeyPath:@"tableView" context:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
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
    header.contentView.backgroundColor = [UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f];
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setTextAlignment:NSTextAlignmentCenter];
    [header.textLabel setFont:[UIFont systemFontOfSize:14]];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ZPFSelectViewController *selectViewController = [[ZPFSelectViewController alloc] init];
    if (indexPath.section == 1) {
        ZPFCenterTodayJSONModel *json = [[ZPFCenterTodayJSONModel alloc] init];

        json = self.mutableArray[indexPath.section - 1];
        self.IDString = [json.stories[indexPath.row] id];
        self.titleString = [json.stories[indexPath.row] title];
        NSArray *array = [json.stories[indexPath.row] images];
        self.imageString = [array componentsJoinedByString:@","];
    } else {
        ZPFSelectJsonModel *json1 = [[ZPFSelectJsonModel alloc] init];
        json1 = self.mutableArray[indexPath.section - 1];
        self.IDString = [json1.stories[indexPath.row] id];
        self.titleString = [json1.stories[indexPath.row] title];
        NSArray *array1 = [json1.stories[indexPath.row] images];
        self.imageString = [array1 componentsJoinedByString:@","];
    }
    
    selectViewController.stringID = self.IDString;
    selectViewController.titleString = self.titleString;
    selectViewController.imageString = self.imageString;

    selectViewController.section = indexPath.section;
    selectViewController.row = indexPath.row;
    
//    selectViewController.IDStringMutableArray = self.centerView.mutableArray;
    
    selectViewController.idStringMutableArray = self.mutableArray;
    
    
    
//    NSDictionary *dict = @{@"mutableArray": self.mutableArray};
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pass" object:nil userInfo:dict];
    
//    NSLog(@"=-=-=-=-=-=-=-=%@", self.centerView.mutableArray);

    [self.navigationController pushViewController:selectViewController animated:YES];
    
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

//tableView滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    
    if (scrollView.contentOffset.y < (220 + self.centerView.centerTodayJsonModel.stories.count * 90) ) {
        self.navigationController.navigationBar.hidden = NO;
        self.image = [ZPFCenterViewController createImageWithColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
        self.centerView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.image1 = [ZPFCenterViewController imageByApplyingAlpha:scrollView.contentOffset.y/220 image:self.image];
        [self.navigationController.navigationBar setBackgroundImage:self.image1 forBarMetrics:UIBarMetricsDefault];
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
    } else {
        self.navigationController.navigationBar.hidden = YES;
        self.centerView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.navigationController.navigationBar.translucent = YES;
        [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    }
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
//    [self.view layoutIfNeeded];
   
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    float y = offset.y + bounds.size.height;
    float h = contentSize.height;
    float reload_distance = 10;
    
//    NSLog(@"---%f", y);
//    NSLog(@"===%f", h);
//    NSLog(@"%f", h + reload_distance);
    

    if (y > h + reload_distance ) {
        if (self.isLoading) {
            return;
        } else {
            [self updateAnnotationArray1];
//            self.days -- ;
            self.isLoading = YES;
        }

    } else {
        
    }
    
//    [self.centerView.tableView reloadData];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
