//
//  webViewController.h
//  TianZeLan
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface webViewController : UIViewController<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong) NSString *urlstr;
@property(nonatomic,strong) NSString *headerstr;
@property(nonatomic,strong) WKWebView*WebView;


@end
