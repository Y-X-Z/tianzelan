//
//  webViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "webViewController.h"
#import "header.h"

@interface webViewController (){
    UIImageView *imageview;
}
@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    _WebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, kScreenW, kScreenH)];
    _WebView.backgroundColor = [UIColor whiteColor];
    _WebView.UIDelegate = self;
    _WebView.navigationDelegate = self;
    [_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlstr]]];
    [self.view addSubview:_WebView];
    
    if (!imageview) {
        imageview =[YX_myUI createImageViewFrame:CGRectMake(kScreenW/2-130, 100, 260, 260) imageName:@"no_image.9"];
        [self.view addSubview:imageview];
    }else{
        imageview.hidden=NO;
    }
}
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    imageview.hidden=YES;

    
}
@end
