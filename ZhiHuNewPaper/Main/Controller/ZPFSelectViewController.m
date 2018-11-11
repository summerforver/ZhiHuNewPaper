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

@interface ZPFSelectViewController ()<WKUIDelegate, WKNavigationDelegate>

@end

@implementation ZPFSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(self.view);
//    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/4/news/9700723"]]];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"页面开始加载：%s", __FUNCTION__);
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
