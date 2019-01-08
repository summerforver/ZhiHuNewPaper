//
//  ZPFCollectViewController.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/12/14.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPFCollectViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *IDString;
@property (nonatomic, copy) NSString *TitleString;
@property (nonatomic, copy) NSString *ImageString;

@property (nonatomic, strong) NSMutableArray *titleMutableArray;
@property (nonatomic, strong) NSMutableArray *imageMutableArray;

@end
