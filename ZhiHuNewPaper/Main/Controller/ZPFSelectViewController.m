//
//  ZPFSelectViewController.m
//  ZhiHuNewPaper
//
//  Created by 王一卓 on 2018/11/1.
//  Copyright © 2018年 王一卓. All rights reserved.
//

#import "ZPFSelectViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>

@interface ZPFSelectViewController ()

@end

@implementation ZPFSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/4/news/3892357"]]];
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
