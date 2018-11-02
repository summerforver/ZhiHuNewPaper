//
//  ZPFLeftViewController.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZPFLeftViewController;

@protocol LeftControllerDelegate<NSObject>
- (void)leftController: (ZPFLeftViewController *)controller didSelectItemAtIndex: (NSUInteger)index;

@end

@interface ZPFLeftViewController : UIViewController
@property (nonatomic, weak) id <LeftControllerDelegate> delegate;

@end
