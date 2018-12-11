

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
#import "ZPFCommentJSONModel.h"
#import "UILabel+UILabel_LabelHeight.h"

#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@interface ZPFCommentViewController () <UITableViewDelegate, MyCellDelegate>

@property (nonatomic, strong) NSMutableArray *mutableArray;

@end

@implementation ZPFCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
//    self.navigationItem.title = @"82条点评";
//    NSString *string1 = [NSString stringWithFormat:@"%@条点评", self.string];
//    self.navigationItem.title = string1;
//
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.22f green:0.52f blue:0.81f alpha:1.00f]];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.leftBarButtonItem.customView.hidden = YES;

    self.commentView = [[ZPFCommentView alloc] initWithFrame:self.view.bounds];
    self.commentView.tableView.delegate = self;
    
    self.commentView.Mydelegate = self;
    
    self.commentView.tableView.estimatedRowHeight = 0;
    self.commentView.tableView.estimatedSectionHeaderHeight = 0;
    self.commentView.tableView.estimatedSectionFooterHeight = 0;
    
//    self.commentView.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    
    
    [self.view addSubview:self.commentView];
    

    [self.commentView.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.commentView.commentButton addTarget:self action:@selector(pressCommentButton:) forControlEvents:UIControlEventTouchUpInside];

   
    self.commentMutableArray = [[NSMutableArray alloc] init];
    self.commentView.array = self.commentMutableArray;
    
    self.mutableArray = [[NSMutableArray alloc] init];
    self.longHeightArray = [[NSMutableArray alloc] init];
    self.shortHeightArray = [[NSMutableArray alloc] init];
    
    
    self.longCommentHeight = 0.0;
    self.shortCommentHeight = 0.0;
    
    self.longCommentModel.OpenIs = NO;
    
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    self.tapGesture.numberOfTapsRequired = 1;
//    [self.commentView.tableView.tableHeaderView addGestureRecognizer:self.tapGesture];
    self.isOpening = NO;
    self.zhankai = NO;
//    self.zhankai = 0;
    
    self.cellMutableArray = [[NSMutableArray alloc] init];
//
//    [self.cellMutableArray addObject:cellShortArray];
//    [self.cellMutableArray addObject:cellLongArray];
    

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLongComments];
    [self updateShortComments];
    [self updateExtraComments];
    self.flag = 0;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *string1 = [NSString stringWithFormat:@"%@条点评", self.string];
    self.navigationItem.title = string1;
}

- (void)updateLongComments {
    [[ZPFHttpSessionManager sharedManager] fetchLongComment:self.commentIDString succeed:^(ZPFCommentJSONModel *commentModel) {
        self.commentView.longCommentModel = commentModel;
       
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentView.tableView reloadData];
        });
        
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)updateShortComments {
    
    [[ZPFHttpSessionManager sharedManager] fetchShortComment:self.commentIDString succeed:^(ZPFCommentJSONModel *shortCommentModel) {
        self.commentView.shortCommentModel = shortCommentModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentView.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)updateExtraComments {
    
    [[ZPFHttpSessionManager sharedManager] fetchExtraComment:self.commentIDString succeed:^(ZPFExtraCommentJSONModel *extraCommentModel) {
        self.commentView.extraModel = extraCommentModel;
        self.string = self.commentView.extraModel.comments;
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

//    if (indexPath.section == 0) {
//        if (self.longHeightArray.count > indexPath.row) {
//            return [self.longHeightArray[indexPath.row] floatValue];
//        }
//    } else {
//        if (self.shortHeightArray.count > indexPath.row) {
//            return [self.shortHeightArray[indexPath.row] floatValue];
//        }
//    }
    if (indexPath.section == 0) {
        
        NSString *string1 = [self.commentView.longCommentModel.comments[indexPath.row] content];
        NSString *string2 = [[self.commentView.longCommentModel.comments[indexPath.row] replyTo] author];
        NSString *string3 = [[self.commentView.longCommentModel.comments[indexPath.row] replyTo] content];

        CGFloat longHeight;
        if (string2 == NULL || string3 == NULL) {
            longHeight = [ZPFCommentTableViewCell heightWithString:string1];
        } else {
            NSString *string = [NSString stringWithFormat:@"%@\n\n//%@：%@",string1, string2, string3];
            self.huifuString = [NSString stringWithFormat:@"//%@：%@", string2, string3];
            
            
            if ([self.commentView.cellShortArray[indexPath.row] isEqual:@YES]) {
                longHeight = [ZPFCommentTableViewCell heightWithString:string];
            } else {
                longHeight = [ZPFCommentTableViewCell heightWithString:string1] + 53.0;
            }

//            longHeight = [ZPFCommentTableViewCell heightWithString:string];
        }


        NSNumber *number = [NSNumber numberWithFloat:longHeight];
        [self.longHeightArray addObject:number];

        
        return longHeight;
        
//       CGFloat lHeight = [self calcucateCell:indexPath forModel:self.commentView.longCommentModel];
//        return lHeight;
        
//
    } else {
        
        NSString *stringOne = [self.commentView.shortCommentModel.comments[indexPath.row] content];
        
        NSString *stringTwo = [[self.commentView.shortCommentModel.comments[indexPath.row] replyTo] author];
        NSString *stringThree = [[self.commentView.shortCommentModel.comments[indexPath.row] replyTo] content];
 
        CGFloat shortHeight;
        if (stringTwo == NULL || stringThree == NULL) {
            shortHeight = [ZPFCommentTableViewCell heightWithString:stringOne];
        } else {
            NSString *stringZero = [NSString stringWithFormat:@"%@\n\n//%@：%@",stringOne, stringTwo, stringThree];
            
            if ([self.commentView.cellShortArray[indexPath.row] isEqual:@YES]) {
                shortHeight = [ZPFCommentTableViewCell heightWithString:stringZero];
            } else {
                shortHeight = [ZPFCommentTableViewCell heightWithString:stringOne] + 53.0;
            }
//            shortHeight = [ZPFCommentTableViewCell heightWithString:stringZero];
        }
        
        NSNumber *number1 = [NSNumber numberWithFloat:shortHeight];
        
        [self.shortHeightArray addObject:number1];
        
        return shortHeight;
    }
}


//- (void)clickCellButton:(UIButton *)button {
//
//
//   self.isOpening = !self.isOpening;
//    self.zhankai = !self.zhankai;
//
//    CGFloat openHeight = [UILabel getHeightByWidth:310.0/375 * ZPFWidth title:self.huifuString font:[UIFont systemFontOfSize:15.0]];
//    ZPFCommentTableViewCell *cell = (ZPFCommentTableViewCell *)[[button superview] superview];
//    NSIndexPath *indexPath = [self.commentView.tableView indexPathForCell:cell];
//    if (openHeight < 53) {
//        cell.openButton.hidden = NO;
//
//        if (self.isOpening) {
//
////            [self.cellMutableArray[indexPath.section][indexPath.row]  isEqual: @YES];
//            self.isOpening = YES;
//            cell.askLabel.numberOfLines = 0;
//            [cell.openButton setTitle:@"收起" forState:UIControlStateNormal];
//            self.zhankai = YES;
//
//
//
//        } else {
//
////            [self.cellMutableArray[indexPath.section][indexPath.row] isEqual:@NO];
//            self.isOpening = NO;
//            cell.askLabel.numberOfLines = 2;
//            [cell.openButton setTitle:@"展开" forState:UIControlStateNormal];
//            self.zhankai = NO;
//
//        }
//    } else {
//        cell.askLabel.numberOfLines = 0;
//        cell.openButton.hidden = YES;
//
//    }
////    if ([self.cellMutableArray[indexPath.section][indexPath.row] isEqual:@NO]) {
////        [self.cellMutableArray[indexPath.section][indexPath.row]  isEqual: @YES];
////    } else {
////        [self.cellMutableArray[indexPath.section][indexPath.row]  isEqual: @YES];
////    }
//
////    for (int i = 0; i < self.cellMutableArray.count; i ++) {
////        for (int j = 0; j < self.cellMutableArray.count; j ++) {
////            if ([self.cellMutableArray[indexPath.section][indexPath.row]  isEqual: @YES]) {
////
////                [self.commentView.tableView beginUpdates];
////                [self.commentView.tableView endUpdates];
////            }
////        }
////    }
////    [self.commentView.tableView beginUpdates];
////    [self.commentView.tableView endUpdates];
//}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (section == 0) {
        self.header = (UITableViewHeaderFooterView *)view;
        self.header.contentView.backgroundColor = [UIColor whiteColor];
        [self.header.textLabel setTextColor:[UIColor blackColor]];
        [self.header.textLabel setTextAlignment:NSTextAlignmentLeft];
        [self.header.textLabel setFont:[UIFont systemFontOfSize:18]];
    } else {
        self.nextHeader = (UITableViewHeaderFooterView *)view;
        self.nextHeader.contentView.backgroundColor = [UIColor whiteColor];
        [self.nextHeader.textLabel setTextColor:[UIColor blackColor]];
        [self.nextHeader.textLabel setTextAlignment:NSTextAlignmentLeft];
        [self.nextHeader.textLabel setFont:[UIFont systemFontOfSize:18]];
        
        
        self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(340.0/375 * ZPFWidth, 4.0/375.0 * ZPFHeight, 25.0/375 *ZPFWidth, 25.0/375 *ZPFWidth)];
        [self.button1 setImage:[UIImage imageNamed:@"shuangjiantouxia"] forState:UIControlStateNormal];
        [self.button1 addTarget:self action:@selector(pressBottomButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.nextHeader addSubview:self.button1];
        
        [self.nextHeader addGestureRecognizer:self.tapGesture];
    
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

- (void)pressBottomButton:(UIButton *)sender {
    
//    self.commentView.tableView.frame = CGRectMake(0, 0, ZPFWidth, ZPFHeight - 35 - )

}

-(void)pressCommentButton: (UIButton *)sender {
    ZPFWriteCommentViewController *writeCommentController = [[ZPFWriteCommentViewController alloc] init];
    
//    [self presentViewController:writeCommentController animated:YES completion:nil];
    [self.navigationController pushViewController:writeCommentController animated:YES];
}

- (void)tapClick{
    
//    for (int i = 0; i < self.longHeightArray.count; i++) {
//        CGFloat height = [self.longHeightArray[i] floatValue];
//        self.longCommentHeight += height;
//    }
//    for (int j = 0; j < self.shortHeightArray.count; j++) {
//        CGFloat height1 = [self.shortHeightArray[j] floatValue];
//        self.shortCommentHeight += height1;
//    }
    
    
    
    if (self.flag) {
        self.flag = 0;
//        [UIView animateWithDuration:0.1 animations:^{
//            self.commentView.tableView.contentOffset = CGPointMake(0, self.longCommentHeight);

//        }];

        
    } else {
        self.flag = 1;
        
//        [UIView animateWithDuration:0.1 animations:^{
//            self.commentView.tableView.contentOffset = CGPointMake(0, -self.longCommentHeight - 40 );

//        }];

    }
    
    self.commentView.fflag = self.flag;
    
    
    [self.commentView.tableView reloadData];
    if (self.commentView.fflag == 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.commentView.tableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionTop animated:NO];
    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
