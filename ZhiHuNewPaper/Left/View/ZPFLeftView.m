//
//  ZPFLeftView.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/5.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFLeftView.h"
#import <Masonry.h>
#import "ZPFFooterView.h"
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@implementation ZPFLeftView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        [self addLeftItems];
        [self addView];
    }
    return self;
}
- (void)addView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 220.0 / 375.0 * ZPFWidth, ZPFHeight) style:UITableViewStylePlain];
    
//    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    self.tableView.scrollEnabled = NO;
    
     [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
//    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    ZPFFooterView *footView = [[ZPFFooterView alloc] init];
    [self.tableView setTableFooterView:footView];
    
    
    
    [self addSubview:self.tableView];
    
    
    
   
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    if (indexPath.section == 0) {
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
//            self.label = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 160, 30)];
            
            self.label = [[UILabel alloc] init];
            
            self.label.text = @"summerforver";
            self.label.textColor = [UIColor colorWithRed:0.53f green:0.55f blue:0.56f alpha:1.00f];
            self.label.font = [UIFont systemFontOfSize:18.0];
//            cell2.textLabel.text = @"summerforver";
//            cell2.textLabel.textColor = [UIColor colorWithRed:0.53f green:0.55f blue:0.56f alpha:1.00f];
//            cell2.textLabel.font = [UIFont systemFontOfSize:18.0];
//            cell2.imageView.image = [UIImage imageNamed:@"s.jpg"];
            
            cell2.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            self.button = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 40, 40)];
            self.button = [[UIButton alloc] init];
            
            self.button.layer.masksToBounds = YES;
            self.button.layer.cornerRadius = (40.0/375.0 * ZPFWidth) / 2;
            
            [self.button setImage:[UIImage imageNamed:@"s.jpg"] forState:UIControlStateNormal];
            
            [cell2 addSubview:self.label];
            [cell2 addSubview:self.button];
            
            [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(70.0/375.0 * ZPFWidth);
                make.top.mas_equalTo(35.0/667.0 * ZPFHeight);
                
            }];
            
            [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(40.0/375.0 * ZPFWidth);
                make.height.mas_equalTo(40.0/667.0 * ZPFHeight);
                make.left.mas_equalTo(15.0/375.0 * ZPFWidth);
                make.top.mas_equalTo(30.0/667.0 * ZPFHeight);
            }];
            
        }
        
        return cell2;
    }
    
    
    if (indexPath.section == 2) {
        if (cell == nil) {
            cell1.tag = 1;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text = @"首页";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.imageView.image = [UIImage imageNamed:@"shouye.png"];
            cell.backgroundColor = [UIColor colorWithRed:0.11f green:0.13f blue:0.16f alpha:1.00f];
            cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    } else if (indexPath.section == 1){
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            
           
            
            cell1.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            NSArray *titleArray = [NSArray arrayWithObjects:@"收藏", @"消息", @"设置", nil];
            NSArray *pictureArray = [NSArray arrayWithObjects:@"shoucang",@"xiaoxi",@"shezhi", nil];
            
            for (int i = 0; i < 3; i++) {
                
                
                UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(70*i + 22, 7, 20, 20)];
               
                [button1 setImage:[UIImage imageNamed:pictureArray[i]] forState:UIControlStateNormal];
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(70*i + 20, 32, 30, 15)];
                label1.textColor = [UIColor colorWithRed:0.53f green:0.55f blue:0.56f alpha:1.00f];;
                label1.font = [UIFont systemFontOfSize:11.0];
                label1.text = titleArray[i];
                
                [cell1 addSubview:button1];
                [cell1 addSubview:label1];
                
            }
            
        
            
        }
        return cell1;
        
    } else {
        UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (cell4 == nil) {
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            cell4.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
            cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell4;
    }
    
}


@end
