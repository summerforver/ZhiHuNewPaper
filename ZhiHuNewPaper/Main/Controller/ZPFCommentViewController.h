//
//  ZPFCommentViewController.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/20.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFCommentView.h"
#import "ZPFHttpSessionManager.h"
#import "ZPFCommentJSONModel.h"

@interface ZPFCommentViewController : UIViewController

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZPFCommentView *commentView;
@property (nonatomic, copy) NSString *commentIDString;
@property (nonatomic, strong) NSMutableArray *commentMutableArray;

@end
