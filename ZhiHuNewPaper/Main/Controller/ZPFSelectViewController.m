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
#import "ZPFCommentViewController.h"
#import "ZPFMyActivityIndicatorView.h"

#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@interface ZPFSelectViewController ()<WKUIDelegate, WKNavigationDelegate>

@end

@implementation ZPFSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];

    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, ZPFHeight - (40.0/667.0 * ZPFHeight), ZPFWidth, (40.0/667.0 * ZPFHeight))];
    self.footView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *picture = [NSArray arrayWithObjects:@"zuo",@"xia",@"dianzan", @"zhuanfa", @"pinglun", nil];
    
    for (int i = 0; i < 5; i++) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake((75.0 / 375 * ZPFWidth )*i + 25.0/375 * ZPFWidth, 9, 25.0/375 *ZPFWidth, 25.0/375 *ZPFWidth)];
        self.button.tag = i + 1;
        
        [self.button setImage:[UIImage imageNamed:picture[i]] forState:UIControlStateNormal];
        
        [self.footView addSubview:self.button];
        
        [self.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
//    [self.view addSubview:self.footView];
    
    NSString *stringId = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@",self.stringID];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringId]]];
}
- (void) pressButton: (UIButton *)sender {
    
    if (sender.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (sender.tag == 5) {
        ZPFCommentViewController *commentViewController = [[ZPFCommentViewController alloc] init];
        
        commentViewController.commentIDString = self.stringID;
        
        [self.navigationController pushViewController:commentViewController animated:YES];
    }
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
}


/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"页面开始加载时：%s", __FUNCTION__);
//    self.myActivityIndicatorView = [[ZPFMyActivityIndicatorView alloc]init];
//    [self.view addSubview:_myActivityIndicatorView];
//    // 动画开始
//    [_myActivityIndicatorView startAnimating];
//
    
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"内容返回：%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"页面加载完成：%s", __FUNCTION__);
    // 动画结束
    [_myActivityIndicatorView stopAnimating];
    
    [self.view addSubview:self.footView];
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"加载失败：%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"接收到服务器跳转请求之后：%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"收到响应后，决定是否跳转");
    
    // 如果响应的地址是百度，则允许跳转
//    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"news-at.zhihu.com/api/4/news/3892357"]) {
    
        
        // 允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
//        return;
//    }
    // 不允许跳转
//    decisionHandler(WKNavigationResponsePolicyCancel);
}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"发送请求之前，决定是否跳转");
    self.myActivityIndicatorView = [[ZPFMyActivityIndicatorView alloc]init];
    [self.view addSubview:_myActivityIndicatorView];
    // 动画开始
    [_myActivityIndicatorView startAnimating];
    
    
    // 如果请求的是百度地址，则延迟5s以后跳转
//    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"news-at.zhihu.com/api/4/news/3892357"]) {
    
        
        //        // 延迟5s之后跳转
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //            // 允许跳转
        //            decisionHandler(WKNavigationActionPolicyAllow);
        //        });
        
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }
    // 不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
