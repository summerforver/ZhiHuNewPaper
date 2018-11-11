//
//  ZPFJSViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/6.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFJSViewController.h"
#import <WebKit/WebKit.h>

@interface ZPFJSViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

- (IBAction)refreshButtonPressed:(id)sender;


@end

@implementation ZPFJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
