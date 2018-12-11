//
//  ZPFCommentTableViewCell.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/20.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFCommentJSONModel.h"

//@class ZPFCommentTableViewCell;


@interface ZPFCommentTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *articleLabel;
@property (nonatomic, strong) UILabel *askLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *zanButton;
@property (nonatomic, strong) UIButton *openButton;
@property BOOL isOpening;
//@property (nonatomic, weak) id <MyCellDelegate> delegate;
@property (nonatomic, strong) ZPFCommentJSONModel *commentModel;
+ (CGFloat)heightWithString:(NSString *)comment;
+ (CGFloat)cellHeightWithString:(NSString *)comment;
- (void)openButtonShow:(NSString *)stringOpen isOpen:(BOOL)isOpen;
@end
