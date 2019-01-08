//
//  ZPFCommentView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/21.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCommentView.h"
#import "ZPFCommentTableViewCell.h"
#import "ZPFCommentJSONModel.h"
#import <UIImageView+WebCache.h>
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height


@implementation ZPFCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.longCommentModel = [[ZPFCommentJSONModel alloc] init];
        self.shortCommentModel = [[ZPFCommentJSONModel alloc] init];
        self.extraModel = [[ZPFExtraCommentJSONModel alloc] init];
        self.array = [[NSMutableArray alloc] init];
        _cellShortArray = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO]];
        _cellLongArray = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,]];
        [self initView];
        
    }
    return self;

}

- (void)initView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, ZPFHeight - 35) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZPFCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self addSubview:self.tableView];
    
    
    self.footView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height, ZPFWidth, 35)];
    self.footView1.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
    [self addSubview:self.footView1];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(13.0/375 * ZPFWidth, 5.0/375.0 * ZPFHeight, 17.0/375 *ZPFWidth, 17.0/375 *ZPFWidth)];
    [self.button setImage:[UIImage imageNamed:@"zuobian"] forState:UIControlStateNormal];
    
    [self.footView1 addSubview:self.button];
    
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(160.0/375*ZPFWidth, 2.0/375.0*ZPFHeight, 90.0/375*ZPFWidth, 15.0/375*ZPFHeight)];
    [self.commentButton setImage:[UIImage imageNamed:@"xiedianping"] forState:UIControlStateNormal];
    [self.commentButton setTitle:@"写点评" forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.commentButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.footView1 addSubview:self.commentButton];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSString *string = [NSString stringWithFormat:@"%@条长评", self.extraModel.long_comments];
        return string;
    } else {
        NSString *string1 = [NSString stringWithFormat:@"%@条短评", self.extraModel.short_comments];
        return string1;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *array1 = [[NSArray alloc] initWithArray:self.longCommentModel.comments];
        return array1.count;
    } else {
        if (self.fflag) {
            NSArray *array2 = [[NSArray alloc] initWithArray:self.shortCommentModel.comments];
            return array2.count;
        } else {
            return 0;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

//- (void)cellheight:(ZPFCommentTableViewCell *)cell {
//    [cell.openButton addTarget:self action:@selector(pressOpenButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.open = cell.isOpening;
//
//}
//
//- (void)pressOpenButton:(UIButton *)sender {
//    NSLog(@"123");
//    self.open = !self.open;
//    if (self.open) {
//        self.open = NO;
//        [sender setTitle:@"收起" forState:UIControlStateNormal];
//    } else {
//        self.open = YES;
//        [sender setTitle:@"展开" forState:UIControlStateNormal];
//    }
//
//}




- (void)creatCell:(ZPFCommentTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath forModel:(ZPFCommentJSONModel *)model {
    cell.nameLabel.text = [model.comments[indexPath.row] author];
    NSString *string1 = [model.comments[indexPath.row] content];
    NSString *string2 = [[model.comments[indexPath.row] replyTo] author];
    NSString *string3 = [[model.comments[indexPath.row] replyTo] content];
    
    
    [cell.openButton addTarget:self action:@selector(pressOpenButton:) forControlEvents:UIControlEventTouchUpInside];
    

    cell.articleLabel.text = string1;
    
    if (string2 != NULL && string3 != NULL) {
        NSString *string = [NSString stringWithFormat:@"//%@：%@", string2, string3];
        NSLog(@"===%ld",(long)indexPath.row);
        if ([_cellShortArray[indexPath.row] isEqual:@NO]) {
            [cell openButtonShow:string isOpen:NO];
        }else{
            [cell openButtonShow:string isOpen:YES];
        }
        cell.askLabel.text = string;
    } else {
        cell.askLabel.text = @" ";
        cell.openButton.hidden = YES;
    }
    
    cell.timeLabel.text = [model.comments[indexPath.row] time];

    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@", [model.comments[indexPath.row] avatar]];
    [mutableString insertString:@"s" atIndex:4];

    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:mutableString]];
    [cell.zanButton setTitle:[model.comments[indexPath.row] likes] forState:UIControlStateNormal];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)pressOpenButton:(UIButton *)sender {
    ZPFCommentTableViewCell *cell = (ZPFCommentTableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([_cellShortArray[indexPath.row] isEqual:@NO]) {
        _cellShortArray[indexPath.row] = @YES;
    }else{
        _cellShortArray[indexPath.row] = @NO;
    }
    
    if ([_cellLongArray[indexPath.row] isEqual:@NO]) {
        _cellLongArray[indexPath.row] = @YES;
    } else {
        _cellLongArray[indexPath.row] = @NO;
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

//    if (self.Mydelegate && [self.Mydelegate respondsToSelector:@selector(clickCellButton:)]) {
//        [self.Mydelegate clickCellButton:sender];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        ZPFCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [self creatCell:cell forIndexPath:indexPath forModel:self.longCommentModel];
        
        return cell;
    } else {
        ZPFCommentTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [self creatCell:cell1 forIndexPath:indexPath forModel:self.shortCommentModel];

        return cell1;
    }
}

@end
