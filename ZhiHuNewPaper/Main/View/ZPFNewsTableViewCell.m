//
//  ZPFNewsTableViewCell.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFNewsTableViewCell.h"
#import <Masonry.h>
#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@implementation ZPFNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, 250, 70)];
//        self.textView = [[UITextView alloc] init];
//        self.textView.font = [UIFont systemFontOfSize:17.0];
//        self.textView.scrollEnabled = NO;
//        
//        [self addSubview:self.textView];
//    
//        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(250.0/375.0 * ZPFWidth, 70.0/667.0 * ZPFHeight));
//            make.top.mas_equalTo(10.0/667.0 * ZPFHeight);
//            make.left.mas_equalTo(15.0/375.0 * ZPFWidth);
//        }];
        
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:17.0];
        //label自动换行
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.numberOfLines = 0;

        [self addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(250.0/375.0 * ZPFWidth, 70));
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15.0/375.0 * ZPFWidth);
        }];
        
        
        
        
//        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 75, 60)];
        self.pictureImageView = [[UIImageView alloc] init];
        [self addSubview:self.pictureImageView];
        
                [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.size.mas_equalTo(CGSizeMake(75.0/375.0 * ZPFWidth, 60.0/667.0 * ZPFHeight));
                    make.size.mas_equalTo(CGSizeMake(75.0/375.0 * ZPFWidth, 60));
//                    make.top.bottom.mas_equalTo(self.textView);
                    make.top.mas_equalTo(15);
                    make.left.mas_equalTo(280.0/375.0 * ZPFWidth);
//                    make.left.mas_equalTo(290);
//                    make.right.mas_equalTo(-15);
        
        
                }];
    }
    return self;
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(100);
//    }];
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
