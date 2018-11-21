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
        self.array = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;

}

- (void)initView {
    
    self.footView1 = [[UIView alloc] initWithFrame:CGRectMake(0, (ZPFHeight - (35.0/667.0 * ZPFHeight)), ZPFWidth, (35.0/667.0 * ZPFHeight))];
    self.footView1.backgroundColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
    [self addSubview:self.footView1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, ZPFHeight - (64.0/667.0 * ZPFHeight) - (35.0/667.0 * ZPFHeight)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZPFCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self addSubview:self.tableView];
    
    
    
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return 5;
    if (section == 0) {
        NSArray *array1 = [[NSArray alloc] init];
        array1 = self.longCommentModel.comments;
        NSLog(@"-----%ld", array1.count);
        return array1.count;
        
        
    } else {
        return 5;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"35条长评";
    } else {
        return @"120条短评";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    //        cell.textLabel.text = @"123";
    //
    //    }
    //    return cell;
    if (indexPath.section == 0) {
        ZPFCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        
        cell.nameLabel.text = [self.longCommentModel.comments[indexPath.row] author];
        cell.articleLabel.text = [self.longCommentModel.comments[indexPath.row] content];
        cell.timeLabel.text = [self.longCommentModel.comments[indexPath.row] time];
//        NSString *string = [self.longCommentModel.comments[indexPath.row] avatar];
        [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:[self.longCommentModel.comments[indexPath.row] avatar]]];
        
        return cell;
    } else {
        ZPFCommentTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell1.nameLabel.text = @"sbuwdsw";
        cell1.articleLabel.text = @"等会我 i 的好几万的和金额为 i 符合 i 哦我减肥诶飞机票违法金额我发金额我就强迫去房间哦貔气氛就饿哦去福建福建哦企鹅减肥迫切发疯哦额前风景";
        cell1.timeLabel.text = @"11-19 18:02";
        
        return cell1;
    }
    
    
}


@end
