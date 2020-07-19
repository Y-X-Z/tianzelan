//
//  detailViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "detailViewController.h"
#import "header.h"

@interface detailViewController ()<UMSocialShareMenuViewDelegate>

@end

@implementation detailViewController


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, isheight, kScreenW, kScreenH-isheight)];
        _WebView.scrollView.scrollEnabled = YES;
        _WebView.delegate = self;
        [self.view addSubview:_WebView];
        
    }
    return self;
}
-(UIWebView *)getWebView{
    return  _WebView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}
- (IBAction)shareto:(id)sender {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager setShareMenuViewDelegate:self];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (platformType==UMSocialPlatformType_WechatSession) {
            [self shareToPlatformType:platformType];
        }if (platformType==UMSocialPlatformType_WechatTimeLine) {
            [self shareToPlatformType:platformType];
        }if (platformType==UMSocialPlatformType_QQ) {
            [self shareToPlatformType:platformType];
        }if (platformType==UMSocialPlatformType_Qzone) {
            [self shareToPlatformType:platformType];
        }
    }];
}
- (void)shareToPlatformType:(UMSocialPlatformType)platformType{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"小海豚给你送钱了" descr:@"独家淘宝专享合作优惠券,这里不够下载海豚社区全部免费拿走" thumImage:[UIImage imageNamed:@"ich"]];
    shareObject.webpageUrl =@"https://itunes.apple.com/cn/app/%E6%A2%A6%E6%83%B3%E5%B0%8F%E9%95%87-township/id781424368?mt=12";
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            //[JRToast showWithText:@"感谢您的分享" bottomOffset:60.f duration:1.0];
        }
    }];
}


@end
