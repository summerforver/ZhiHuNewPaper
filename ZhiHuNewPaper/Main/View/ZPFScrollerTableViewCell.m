//
//  ZPFScrollerTableViewCell.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFScrollerTableViewCell.h"
#import <Masonry.h>

#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

static const int imageBtnCount = 3;
@implementation ZPFScrollerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ZPFWidth, 220)];
        [self addSubview:self.scrollerView];
        //        [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.mas_equalTo(self.contentView);
        //        }];
        //
    }
    return self;
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
