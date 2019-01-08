//
//  ZPFSelectViewController.h
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ZPFWriteCommentViewController.h"
#import "ZPFMyActivityIndicatorView.h"
#import "ZPFShareView.h"

@interface ZPFSelectViewController : UIViewController
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *stringID;
@property (nonatomic, copy) NSString *IDstring;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *imageString;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) ZPFShareView *shareView;

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) ZPFMyActivityIndicatorView *myActivityIndicatorView;
@property BOOL isloading;

@property NSInteger section;
@property NSInteger row;
@property (nonatomic, strong) NSMutableArray *IDStringMutableArray;
@property (nonatomic, strong) NSMutableArray *idStringMutableArray;

@end
