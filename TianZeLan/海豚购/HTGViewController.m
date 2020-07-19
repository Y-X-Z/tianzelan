//
//  HTGViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HTGViewController.h"
#import "header.h"

@interface HTGViewController ()<UMSocialShareMenuViewDelegate>

@end

@implementation HTGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    [self setTabBarFrame:CGRectMake(0, isheight, kScreenW, 44)
        contentViewFrame:CGRectMake(0, isheight+44, kScreenW, kScreenH - isheight - 44 - isboheight)];
    self.tabBar.itemTitleColor = RGBA(102, 102, 102, 1);
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:15];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:15];
    self.tabBar.leadAndTrailSpace = 20;
    
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.indicatorColor = [UIColor redColor];
    
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(35, 15, 0, 15) tapSwitchAnimated:YES];
    [self.tabBar setScrollEnabledAndItemFitTextWidthWithSpacing:30];
    
    [self setContentScrollEnabled:YES tapSwitchAnimated:NO];
    self.loadViewOfChildContollerWhileAppear = YES;
    [self initViewControllers];
}
- (void)initViewControllers {
    TodaysellVController *controller1 = [[TodaysellVController alloc]init];
    controller1.yp_tabItemTitle = @"今日特卖";
    
    GirlCloVController *controller2 = [[GirlCloVController alloc]init];    controller2.yp_tabItemTitle = @"女装";

    XieBaoVController *controller3 = [[XieBaoVController alloc]init];    controller3.yp_tabItemTitle = @"鞋包搭配";
    
    MeiZhViewController *controller4 = [[MeiZhViewController alloc] init];
    controller4.yp_tabItemTitle = @"美妆个护";
    
    BoyCloseVController *controller5 = [[BoyCloseVController alloc] init];
    controller5.yp_tabItemTitle = @"男装";
    
    NeiYiViewController *controller6 = [[NeiYiViewController alloc] init];
    controller6.yp_tabItemTitle = @"内衣";
    
    FoodsViewController *controller7 = [[FoodsViewController alloc] init];
    controller7.yp_tabItemTitle = @"食品";
    
    JiaJJViewController *controller8 = [[JiaJJViewController alloc] init];
    controller8.yp_tabItemTitle = @"家居家装";
    
    ShuMAVController *controller9 = [[ShuMAVController alloc] init];
    controller9.yp_tabItemTitle = @"数码";
    
    SportsViewController *controller10 = [[SportsViewController alloc] init];
    controller10.yp_tabItemTitle = @"运动";
    
    MuYingVController *controller11 = [[MuYingVController alloc] init];
    controller11.yp_tabItemTitle = @"母婴";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, controller5, controller6, controller7,controller8, controller9, controller10, controller11, nil];
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
            [JRToast showWithText:@"感谢您的分享" bottomOffset:60.f duration:1.0];
        }
    }];
}


@end
