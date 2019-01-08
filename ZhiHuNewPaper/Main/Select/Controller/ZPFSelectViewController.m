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
#import "ZPFShareView.h"

#define ZPFWidth [UIScreen mainScreen].bounds.size.width
#define ZPFHeight [UIScreen mainScreen].bounds.size.height

@interface ZPFSelectViewController ()<WKUIDelegate, WKNavigationDelegate,UIScrollViewDelegate>

@end

@implementation ZPFSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 10, ZPFWidth, ZPFHeight - (50.0/667.0 * ZPFHeight))];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];

    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, ZPFHeight - (40.0/667.0 * ZPFHeight), ZPFWidth, (40.0/667.0 * ZPFHeight))];
    self.footView.backgroundColor = [UIColor whiteColor];
    
//
    NSArray *picture = [NSArray arrayWithObjects:@"zuo",@"xia",@"dianzan", @"zhuanfa", @"pinglun", nil];
//
    for (int i = 0; i < 5; i++) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake((75.0 / 375 * ZPFWidth )*i + 25.0/375 * ZPFWidth, 9, 25.0/375 *ZPFWidth, 25.0/375 *ZPFWidth)];
        self.button.tag = i + 1;
        
        [self.button setImage:[UIImage imageNamed:picture[i]] forState:UIControlStateNormal];
        
        
//        if (i == 2) {
//            [self.button setTitle:@"12" forState:UIControlStateNormal];
//            [self.button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
//        }
        

        [self.footView addSubview:self.button];
        
        [self.button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.isloading = NO;
//    self.IDStringMutableArray = [[NSMutableArray alloc] init];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pass:) name:@"pass" object:nil];
    
    
    NSString *stringId = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@",self.stringID];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringId]]];
}
- (void)pressButton: (UIButton *)sender {
    
    if (sender.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (sender.tag == 2) {
        
        [self updateWebView];
    }
    
    if (sender.tag == 4) {
        self.shareView = [[ZPFShareView alloc] initWithFrame:CGRectMake(0, ZPFHeight/2, ZPFWidth, ZPFHeight/2)];
        self.shareView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.97f alpha:1.00f];
        
        [self.view addSubview:self.shareView];
        
        [self.shareView.deleteButton addTarget:self action:@selector(pressDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView.shareButton addTarget:self action:@selector(pressShareButtnon) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (sender.tag == 5) {
        ZPFCommentViewController *commentViewController = [[ZPFCommentViewController alloc] init];
        
        commentViewController.commentIDString = self.stringID;
        
        [self.navigationController pushViewController:commentViewController animated:YES];
    }

}

- (void)pressDeleteButton {
    [self.shareView removeFromSuperview];
    
}

- (void)pressShareButtnon {
    
    [self.shareView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZPFWidth/2 - 50, ZPFHeight/2 - 50 , 100, 100)];
    label.text = @"已收藏";
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17.0];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:2.0 animations:^{
        label.alpha = 0.0;
    } completion:^(BOOL finished) {
        // 动画完毕从父视图移除
        [label removeFromSuperview];
    }];
    
    NSDictionary *dic = @{@"string": self.stringID, @"titleString": self.titleString, @"imageString": self.imageString};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pass" object:nil userInfo:dic];
}

//- (void) pass:(NSNotification *)text {
//    self.IDStringMutableArray = text.userInfo[@"mutableArray"];
//
//}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    float y = offset.y + bounds.size.height;
//    NSLog(@"-=-=-=%f",y);
    float h = contentSize.height;
//    NSLog(@"121212   %f",h);
//    float reload_distance = 10;
    
        if (y == h) {
            if (self.isloading) {
                return ;
            }  else {
                [self updateWebView];
                
            }
        }
    
//    if (y > h + reload_distance && scrollView.contentSize.height != 0) {
//        if (self.isloading) {
//            return ;
//        }  else {
//            [self updateWebView];
//
//        }
//
//    }
//


}

- (void)updateWebView {
    
    if (self.section == 1) {
        self.row ++;
        ZPFCenterTodayJSONModel *json = [[ZPFCenterTodayJSONModel alloc] init];
        json = self.idStringMutableArray[self.section - 1];
        
        if (self.row == json.stories.count) {
            self.section ++;
            self.row = self.row - json.stories.count;
            
            ZPFSelectJsonModel *json2 = [[ZPFSelectJsonModel alloc] init];

            json2 = self.idStringMutableArray[self.section - 1];

            self.IDstring = [json2.stories[self.row] id];
            
        } else {
            self.IDstring = [json.stories[self.row] id];
        }
    } else {
        
        self.row ++;
        
        ZPFSelectJsonModel *json1 = [[ZPFSelectJsonModel alloc] init];
        
        json1 = self.idStringMutableArray[self.section - 1];
        
        NSLog(@"row:-----%ld", self.row);
        NSLog(@"section:=====%ld", self.section);
        
        if (self.row == json1.stories.count) {
            self.section ++;
            self.row = self.row - json1.stories.count;
            
            ZPFSelectJsonModel *json3 = [[ZPFSelectJsonModel alloc] init];
            
            json3 = self.idStringMutableArray[self.section - 1];
            
            self.IDstring = [json3.stories[self.row] id];
            
            
        } else {
            self.IDstring = [json1.stories[self.row] id];
        }
    
    }

    
//    NSString *string = self.IDStringMutableArray[self.row];

    NSString *stringId1 = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@",self.IDstring];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringId1]]];
    
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
    
//    NSLog(@"页面开始加载时：%s", __FUNCTION__);
    
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
    
//    NSLog(@"内容返回：%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
//    NSLog(@"页面加载完成：%s", __FUNCTION__);
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
    
//    NSLog(@"加载失败：%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
//    NSLog(@"接收到服务器跳转请求之后：%s", __FUNCTION__);
}

/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
//    NSLog(@"收到响应后，决定是否跳转");
    
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
    
//    NSLog(@"发送请求之前，决定是否跳转");
    
    

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
