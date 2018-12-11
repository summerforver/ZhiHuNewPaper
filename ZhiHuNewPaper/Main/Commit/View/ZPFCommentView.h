//
//  ZPFCommentView.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/21.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFCommentJSONModel.h"
#import "ZPFExtraCommentJSONModel.h"
#import "ZPFCommentTableViewCell.h"

@protocol MyCellDelegate<NSObject>
- (void)clickCellButton:(UIButton *)button;
@end

@interface ZPFCommentView : UIView <UITableViewDataSource>

@property (nonatomic, strong) UIView  *footView1;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZPFCommentJSONModel *longCommentModel;
@property (nonatomic, strong) ZPFCommentJSONModel *shortCommentModel;
@property (nonatomic, strong) ZPFExtraCommentJSONModel *extraModel;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSMutableArray *cellShortArray;
@property (nonatomic, strong) NSMutableArray *cellLongArray;
@property (nonatomic, weak) id <MyCellDelegate> Mydelegate;
@property BOOL fflag;
@property BOOL open;

- (void)creatCell:(ZPFCommentTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath forModel:(ZPFCommentJSONModel *)model;
@end
