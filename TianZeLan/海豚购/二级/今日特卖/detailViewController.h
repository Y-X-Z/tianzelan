//
//  detailViewController.h
//  TianZeLan
//
//  Created by apple on 2018/6/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>
@property(nonatomic,strong) NSString *urlstr;
@property(nonatomic,strong) NSString *headerstr;
@property(nonatomic,strong) UIWebView*WebView;

-(UIWebView *)getWebView;


@end
