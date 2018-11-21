

//
//  ZPFCommentViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/20.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCommentViewController.h"
#import "ZPFCommentTableViewCell.h"
#import "ZPFCommentView.h"
#import "ZPFWriteCommentViewController.h"
#import "ZPFHttpSessionManager.h"

#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@interface ZPFCommentViewController () <UITableViewDelegate>

@end

@implementation ZPFCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.title = @"82条点评";
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"82条点评";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0/667 * ZPFHeight, ZPFWidth, ZPFHeight  - (35.0/667.0 * ZPFHeight)) style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.commentView = [[ZPFCommentView alloc] initWithFrame:CGRectMake(0, (64.0/667.0 * ZPFHeight), ZPFWidth, ZPFHeight - (64.0/667.0 * ZPFHeight))];
    
    self.commentView.tableView.delegate = self;
    
    
    [self.view addSubview:self.commentView];
    
//    self.tableView.dataSource = self;
    
//    [self.tableView registerClass:[ZPFCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
//    [self.view addSubview:self.tableView];
    
    
//    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, ZPFHeight - (35.0/667.0 * ZPFHeight), ZPFWidth, (35.0/667.0 * ZPFHeight))];
//    footView.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
//    [self.view addSubview:footView];
//
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(13.0/375 * ZPFWidth, 5.0/375.0 * ZPFHeight, 17.0/375 *ZPFWidth, 17.0/375 *ZPFWidth)];
//    [button setImage:[UIImage imageNamed:@"zuobian"] forState:UIControlStateNormal];
    [self.commentView.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//    [footView addSubview:button];
//
//    UIButton *commentButton = [[UIButton alloc] initWithFrame:CGRectMake(160.0/375*ZPFWidth, 2.0/375.0*ZPFHeight, 90.0/375*ZPFWidth, 15.0/375*ZPFHeight)];
//    [commentButton setImage:[UIImage imageNamed:@"xiedianping"] forState:UIControlStateNormal];
//    [commentButton setTitle:@"写点评" forState:UIControlStateNormal];
//    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    commentButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.commentView.commentButton addTarget:self action:@selector(pressCommentButton:) forControlEvents:UIControlEventTouchUpInside];
//    [footView addSubview:commentButton];
//    
    
   
    self.commentMutableArray = [[NSMutableArray alloc] init];
    self.commentView.array = self.commentMutableArray;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLongComments];
}

- (void)updateLongComments {
    [[ZPFHttpSessionManager sharedManager]fetchLongComment:self.commentIDString succeed:^(ZPFCommentJSONModel *commentModel) {
        self.commentView.longCommentModel = commentModel;
        NSLog(@"%@", self.commentView.longCommentModel);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentView.tableView reloadData];
        });
        
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = [UIColor whiteColor];
    [header.textLabel setTextColor:[UIColor blackColor]];
    [header.textLabel setTextAlignment:NSTextAlignmentLeft];
    [header.textLabel setFont:[UIFont systemFontOfSize:18]];
    if (section == 1) {
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(340.0/375 * ZPFWidth, 4.0/375.0 * ZPFHeight, 25.0/375 *ZPFWidth, 25.0/375 *ZPFWidth)];
        [button1 setImage:[UIImage imageNamed:@"shuangjiantouxia"] forState:UIControlStateNormal];
//        [button1 addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:button1];
    }
}


//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
- (void)pressButton: (UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pressCommentButton: (UIButton *)sender {
    ZPFWriteCommentViewController *writeCommentController = [[ZPFWriteCommentViewController alloc] init];
    
//    [self presentViewController:writeCommentController animated:YES completion:nil];
    [self.navigationController pushViewController:writeCommentController animated:YES];
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
