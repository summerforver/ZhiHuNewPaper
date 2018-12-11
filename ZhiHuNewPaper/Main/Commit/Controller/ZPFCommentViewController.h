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
@property (nonatomic, strong) ZPFCommentView *commentView;
@property (nonatomic, copy) NSString *commentIDString;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSString *huifuString;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) NSMutableArray *commentMutableArray;
@property (nonatomic, strong) UITableViewHeaderFooterView *header;
@property (nonatomic, strong) UITableViewHeaderFooterView *nextHeader;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSMutableArray *longHeightArray;
@property (nonatomic, strong) NSMutableArray *shortHeightArray;



@property (nonatomic, strong) NSMutableArray *cellMutableArray;

@property (nonatomic, strong) ZPFCommentJSONModel *longCommentModel;
@property (nonatomic, strong) ZPFCommentJSONModel *shortCommentModel;
@property (nonatomic, strong) ZPFExtraCommentJSONModel *extraModel;

@property BOOL flag;
@property BOOL isOpening;
@property BOOL zhankai;
//@property int zhankai;

@property CGFloat longCommentHeight;
@property CGFloat shortCommentHeight;

- (void)creatCell:(ZPFCommentTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath forModel:(ZPFCommentJSONModel *)model;


@end
