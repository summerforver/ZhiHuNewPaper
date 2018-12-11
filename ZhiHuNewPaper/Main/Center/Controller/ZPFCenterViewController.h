//
//  ZPFCenterViewController.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZPFCenterView.h"



@protocol CenterControllerDelegate <NSObject>
- (void)centerController: (NSMutableArray *)mutableArray;
@end


@interface ZPFCenterViewController : UIViewController
@property (nonatomic, strong) ZPFCenterView *centerView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, weak) id <CenterControllerDelegate> delegate;

@property (nonatomic, copy) NSString *dateString;
@property int intString;
@property (nonatomic, strong) NSMutableArray *textViewArray;
@property (nonatomic, strong) NSMutableArray *pictureArray;

@property (nonatomic, strong) NSMutableArray *mutableArray;
@property BOOL isLoading;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, copy) NSString *IDString;


@end
