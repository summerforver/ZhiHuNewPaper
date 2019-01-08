//
//  ZPFLeftViewController.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFLeftView.h"
@class ZPFLeftViewController;

@protocol LeftControllerDelegate<NSObject>
- (void)leftController: (ZPFLeftViewController *)controller didSelectItemAtIndex: (NSUInteger)index;

@end

@interface ZPFLeftViewController : UIViewController
@property (nonatomic, weak) id <LeftControllerDelegate> delegate;
@property (nonatomic, strong) ZPFLeftView *leftView;

@property (nonatomic, copy) NSString *stringID;
@property (nonatomic, copy) NSString *stringTitle;
@property (nonatomic, copy) NSString *stringImage;

@end
