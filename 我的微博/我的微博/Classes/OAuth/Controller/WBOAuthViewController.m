//
//  WBOAuthViewController.m
//  我的微博
//
//  Created by wmd on 16/2/21.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "MBProgressHUD+MJ.h"

#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBRootTool.h"



@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//  显示登陆的网页
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];

//  拼接URL字符串
    NSString *strUrl = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",WBOAuthorizeBaseUrl,WBclient_id,WBredirect_uri];
//  创建URL
    NSURL *url = [NSURL URLWithString:strUrl];
//  创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//  加载网页请求
    [webView loadRequest:request];
//  设置代理
    webView.delegate = self;
    
}

#pragma mark - UIWebView 代理方法实现
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//  提示用户正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
}
//加载结束
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
//加载失败时掉用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
//拦截webView请求
//当webView需要加载一个请求的时候，就会掉用这个方法，询问一下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
//  获取code（RequestTolen）
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
//  换取accesToken
        [self accessTokenWithCode:code];
//  不会去加载会掉界面
        return NO;
    }
    
    return YES;
}


//#pragma mark - 换取accessToken
- (void) accessTokenWithCode:(NSString *)code
{
//    发送post请求
//    创建请求管理者
    [WBAccountTool accountWithCode:code success:^{
        [WBRootTool chooseRootViewController:WBKeyWindow];
    } failture:^(NSError *erroe) {
        
    }];

}





@end
