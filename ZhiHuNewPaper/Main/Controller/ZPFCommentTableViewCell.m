//
//  ZPFCommentTableViewCell.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/20.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCommentTableViewCell.h"
#import <Masonry.h>
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@implementation ZPFCommentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView {
//    self.pictureButton = [[UIButton alloc] init];
//    self.pictureButton.layer.masksToBounds = YES;
//    self.pictureButton.layer.cornerRadius = (30.0/375.0 * ZPFWidth) / 2;
//    [self.pictureButton setImage:[UIImage imageNamed:@"s.jpg"] forState:UIControlStateNormal];
//
//    [self addSubview:self.pictureButton];
//
//    [self.pictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(10.0/375 * ZPFWidth);
//        make.top.mas_equalTo(10.0/667 * ZPFHeight);
//        make.width.mas_equalTo(30.0/375 * ZPFWidth);
//        make.height.mas_equalTo(30.0/667 * ZPFHeight);
//
//    }];

    self.pictureImageView = [[UIImageView alloc] init];
    self.pictureImageView.layer.masksToBounds = YES;
    self.pictureImageView.layer.cornerRadius = (30.0/375.0 * ZPFWidth) / 2;
    [self addSubview:self.pictureImageView];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10.0/375 * ZPFWidth);
        make.top.mas_equalTo(10.0/667 * ZPFHeight);
        make.width.mas_equalTo(30.0/375 * ZPFWidth);
        make.height.mas_equalTo(30.0/667 * ZPFHeight);
        
    }];
  

    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.text = @"yaua";
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50.0/375 * ZPFWidth);
        make.top.mas_equalTo(10.0/667 * ZPFHeight);
        make.width.mas_equalTo(100.0/375 * ZPFWidth);
        make.height.mas_equalTo(15.0/667 * ZPFHeight);
        
    }];
    
    
    self.articleLabel = [[UILabel alloc] init];
//    self.articleLabel.text = @"点十五号的和为好和地位和地区的后期为较好的脾气哦我就去拍进去哦貔为借口秋冬季我请假带我去大奖哦我请假哦貔请假哦期待";
    self.articleLabel.textColor = [UIColor blackColor];
    self.articleLabel.font = [UIFont systemFontOfSize:15.0];
    self.articleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.articleLabel.numberOfLines = 0;
    [self addSubview:self.articleLabel];
    
    [self.articleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50.0/375 * ZPFWidth);
        make.top.mas_equalTo(15.0/375 * ZPFHeight);
        make.width.mas_equalTo(310.0/375 * ZPFWidth);
        make.height.mas_equalTo(60.0/667 * ZPFHeight);
    }];
    
    
    
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.text = @"11-19 17:34";
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50.0/375 * ZPFWidth);
        make.bottom.mas_equalTo(-15.0/667 * ZPFHeight);
        make.width.mas_equalTo(70.0/375 * ZPFWidth);
        make.height.mas_equalTo(10.0/667 * ZPFHeight);
        
        
    }];
    
    
    self.zanButton = [[UIButton alloc] init];
    [self.zanButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.zanButton setTitle:@"0" forState:UIControlStateNormal];
    [self.zanButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.zanButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:self.zanButton];
    
    [self.zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25.0/375 * ZPFWidth);
        make.top.mas_equalTo(10.0/667 * ZPFHeight);
        make.width.mas_equalTo(25.0/375 * ZPFWidth);
        make.height.mas_equalTo(15.0/667 * ZPFHeight);
        
    }];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
