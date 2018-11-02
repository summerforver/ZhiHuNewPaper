//
//  ZPFNewsTableViewCell.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFNewsTableViewCell.h"
#import <Masonry.h>

@implementation ZPFNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, 250, 70)];
        self.textView.font = [UIFont systemFontOfSize:17.0];
        self.textView.scrollEnabled = NO;
        
        [self addSubview:self.textView];
        //
        //        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.mas_equalTo(CGSizeMake(250, 70));
        //            make.top.left.mas_equalTo(15);
        //            make.right.mas_equalTo(-100);
        //            make.bottom.mas_equalTo(-15);
        //        }];
        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 75, 60)];
        [self addSubview:self.pictureImageView];
        
        //        [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.mas_equalTo(CGSizeMake(80, 60));
        //            make.top.bottom.mas_equalTo(self.textView);
        //            make.left.mas_equalTo(290);
        //            make.right.mas_equalTo(-15);
        //
        //
        //        }];
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
