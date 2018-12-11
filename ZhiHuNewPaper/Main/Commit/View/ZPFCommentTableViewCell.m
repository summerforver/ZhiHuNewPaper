//
//  ZPFCommentTableViewCell.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/20.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFCommentTableViewCell.h"
#import <Masonry.h>
#import "UILabel+UILabel_LabelHeight.h"
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height
#define K_marginHeight 10
#define K_marginWidth 13



@implementation ZPFCommentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.pictureImageView = [[UIImageView alloc] init];
        self.pictureImageView.layer.masksToBounds = YES;
        self.pictureImageView.layer.cornerRadius = 15;
        [self.contentView addSubview:self.pictureImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.articleLabel = [[UILabel alloc] init];
        self.articleLabel.textColor = [UIColor blackColor];
        self.articleLabel.font = [UIFont systemFontOfSize:15.0];
        self.articleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.articleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.articleLabel];
        
        self.askLabel = [[UILabel alloc] init];
        self.askLabel.textColor = [UIColor blackColor];
        self.askLabel.font = [UIFont systemFontOfSize:15.0];
        self.askLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        self.askLabel.numberOfLines = 0;
//        self.askLabel.hidden = YES;
        [self.contentView addSubview:self.askLabel];
        
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.timeLabel];
        
        self.openButton = [[UIButton alloc] init];
        [self.openButton setTitle:@"展开" forState:UIControlStateNormal];
        [self.openButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.openButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        self.openButton.hidden = YES;
        
//        [self.openButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.openButton];
        
        
        self.zanButton = [[UIButton alloc] init];
        [self.zanButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self.zanButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.zanButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:self.zanButton];
        
        self.isOpening = NO;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.contentView).offset(K_marginHeight);
        make.left.mas_equalTo(self.contentView).offset(K_marginWidth);
        make.width.mas_equalTo(30.0);
        make.height.mas_equalTo(30.0);

    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pictureImageView.mas_top);
        make.left.mas_equalTo(self.pictureImageView.mas_right).offset(K_marginWidth);
        make.width.mas_equalTo(200.0);
        make.height.mas_equalTo(15.0);
        
    }];
    

    
    [self.articleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(K_marginHeight);
        make.width.mas_equalTo(310.0);
//        make.height.mas_equalTo(self.contentView.frame.size.height - 4 * K_marginHeight - 2 * 15);
        
    }];
    
    [self.askLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.articleLabel.mas_bottom).offset(K_marginHeight);
        make.width.mas_equalTo(310.0);
        //        make.height.mas_equalTo(self.contentView.frame.size.height - 4 * K_marginHeight - 2 * 15);
        
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.bottom.mas_equalTo(-K_marginHeight);
        make.width.mas_equalTo(90.0);
        make.height.mas_equalTo(10.0);
    }];
    
    [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-K_marginHeight);
        make.bottom.mas_equalTo(self.timeLabel.mas_bottom);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(10);
    }];

    [self.zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-K_marginHeight);
        make.top.mas_equalTo(self.nameLabel.mas_top);
        make.width.mas_equalTo(35.0);
        make.height.mas_equalTo(15.0);
        
    }];
    
}

//- (void)pressButton:(UIButton *)sender {
//    [self.delegate clickCellButton:sender];
//    self.isOpening = !self.isOpening;
//    if (self.isOpening) {
//        self.isOpening = YES;
//        [sender setTitle:@"收起" forState:UIControlStateNormal];
//    } else {
//        self.isOpening = NO;
//        [sender setTitle:@"展开" forState:UIControlStateNormal];
//    }
//}
- (void)openButtonShow:(NSString *)stringOpen isOpen:(BOOL)isOpen{
    
    CGFloat openHeight = [UILabel getHeightByWidth:310.0/375 * ZPFWidth title:stringOpen font:[UIFont systemFontOfSize:15.0]];
    if (openHeight > 53) {
        self.openButton.hidden = NO;
        if (isOpen) {
            self.askLabel.numberOfLines = 0;
            [self.openButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            self.askLabel.numberOfLines = 2;
            [self.openButton setTitle:@"展开" forState:UIControlStateNormal];
        }
    } else {
        self.askLabel.numberOfLines = 0;
        self.openButton.hidden = YES;
    }

}


+ (CGFloat)heightWithString:(NSString *)comment {

//    ZPFCommentTableViewCell *cell = [[ZPFCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
//    [cell layoutIfNeeded];
//
    CGFloat height = [UILabel getHeightByWidth:310.0/375 * ZPFWidth title:comment font:[UIFont systemFontOfSize:15.0]];
    
//    CGRect frame = cell.articleLabel.frame;
//    CGRect frame1 = cell.timeLabel.frame;
//    CGRect frame2 = cell.nameLabel.frame;
//    return height + frame1.origin.y + frame2.origin.y + 10;
//
    return height + 65.0/667 * ZPFHeight;
}

//+ (CGFloat)cellHeightWithString:(NSString *)comment {
//
//    CGRect rect = [comment boundingRectWithSize:CGSizeMake(ZPFWidth - 24, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
//
//    return rect.size.height + 4 * K_marginHeight + 2 * 15;
//
//}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
