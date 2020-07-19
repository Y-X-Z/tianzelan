//
//  AppDelegate.m
//  TianZeLan
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "header.h"

@interface AppDelegate ()
{
    
    NSString *GOFirst;
    MBProgressHUD *hud;
}
@property (nonatomic, retain) UIView *customSplashView;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *topLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UITextView *discriptText;
@property (nonatomic, retain) UIImageView *logoImage;
@property (nonatomic, retain) UILabel *deviderLabel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UINavigationController *lognvc=[[UINavigationController alloc]init];
    lognvc.navigationBar.hidden=YES;
    self.window.rootViewController=lognvc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];//开发阶段打开日志开关，方便排查错误信息
    [[AlibcTradeSDK sharedInstance] setIsvVersion:@"2.2.2"];
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
    } failure:^(NSError *error) {}];
    [[AlibcTradeSDK sharedInstance]setTaokeParams:nil];
    [[AlibcTradeSDK sharedInstance] setISVCode:@"nieyun_isv_code"];//设置全局的app标识，在电商模块里等同于isv_cod
    [[UMSocialManager defaultManager]openLog:NO];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager]setUmSocialAppkey:@"5b18d447b27b0a306b0000c1"];
    
    [self configUSharePlatforms];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [BaiduMobAdSetting sharedInstance].supportHttps = YES;
    [self setscoll];


//    [GDTSDKConfig setHttpsOn];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        _splash = [[GDTSplashAd alloc] initWithAppId:@"1106479921" placementId:@"7030831464502501"];
//
//        _splash.delegate = self;
//        UIImage *splashImage = [UIImage imageNamed:@"openpage"];
//        if (IS_IPHONEX) {
//            splashImage = [UIImage imageNamed:@"openpage"];
//        } else if ([UIScreen mainScreen].bounds.size.height == 480) {
//            splashImage = [UIImage imageNamed:@"openpage"];
//        }
//        UIImage *backgroundImage = [AppDelegate imageResize:splashImage
//                                                andResizeTo:[UIScreen mainScreen].bounds.size];
//        _splash.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
//        _splash.fetchDelay = 3;
//        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenW,bottomviewH)];
//        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomview"]];
//        logo.frame = self.bottomView.frame;
//        [self.bottomView addSubview:logo];
//        [_splash loadAdAndShowInWindow:self.window withBottomView:self.bottomView];
//        self.splash = _splash;
//    }
    
    return YES;
}
- (void)configUSharePlatforms{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx9addaa9562f812f1" appSecret:@"f477d455f932bec9e8fb1edece6039a3" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx9addaa9562f812f1"  appSecret:@"f477d455f932bec9e8fb1edece6039a3" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106885361" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106885361" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}
-(BOOL)handleOpenURL:(NSURL *)url{
    if ([[UMSocialManager defaultManager]  handleOpenURL:url]) {
        return YES;
    }
    
    return YES;

}
-(BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary*)options{
    if ([[UMSocialManager defaultManager]  handleOpenURL:url]) {
        return YES;
    }
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    if ([[UMSocialManager defaultManager]  handleOpenURL:url options:options]) {
        return YES;
    }if ([[AlibcTradeSDK sharedInstance] application:app openURL:url options:options]) {
        return YES;
    }
    return YES;
}
+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

//- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
//{
//    NSLog(@"%s%@",__FUNCTION__,error);
//    [self setscoll];
//
////    if (GOFirst) {
////        NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
////        NSString *token=[users objectForKey:@"uid"];
////        if (token) {
////            YXtabbarViewController *Log=[[YXtabbarViewController alloc]init];
////            self.window.rootViewController=Log;
////            [JRToast showWithText:@"登录成功" bottomOffset:100.f duration:1.0];
////        }else{
////            LoginViewController *Logg=[[LoginViewController alloc]init];
////            UINavigationController *lognvc=[[UINavigationController alloc]initWithRootViewController:Logg];
////            lognvc.navigationBar.hidden=YES;
////            self.window.rootViewController=lognvc;
////        }
////    }else{
////        ScorollViewController *sc=[[ScorollViewController alloc]init];
////        UINavigationController *lognvc=[[UINavigationController alloc]initWithRootViewController:sc];
////        self.window.rootViewController =lognvc;
////        lognvc.navigationBar.hidden=YES;
////    }
//}
//
//- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//-(void)splashAdClosed:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//    self.splash = nil;
//    [self setscoll];
//}
-(void)setscoll{
    if (![Def valueForKey:@"GOFirst"]) {
        ScorollViewController *sc=[[ScorollViewController alloc]init];
        UINavigationController *lognvc=[[UINavigationController alloc]initWithRootViewController:sc];
        self.window.rootViewController =lognvc;
        lognvc.navigationBar.hidden=YES;
        [Def setValue:@"YES" forKey:@"GOFirst"];
    }else{
        YXtabbarViewController *Log=[YXtabbarViewController sharedManager];
        self.window.rootViewController=Log;
        hud = [MBProgressHUD showHUDAddedTo:Log.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"欢迎来到海豚社区";
        hud.offset = CGPointMake(0.f, 200);
        [hud hideAnimated:YES afterDelay:2.f];
//        NSString *token=[Def objectForKey:@"uid"];
//        if (token) {
//            YXtabbarViewController *Log=[YXtabbarViewController sharedManager];
//            self.window.rootViewController=Log;
//            hud = [MBProgressHUD showHUDAddedTo:Log.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.label.text = @"登录成功";
//            hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
//            [hud hideAnimated:YES afterDelay:2.f];
//        }else{
//            YXtabbarViewController *Log=[YXtabbarViewController sharedManager];
//            self.window.rootViewController=Log;
//            hud = [MBProgressHUD showHUDAddedTo:Log.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.label.text = @"欢迎来到海豚社区";
//            hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
//            [hud hideAnimated:YES afterDelay:2.f];
//        }
    }
}
//- (void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)splashAdDidPresentFullScreenModal:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)splashAdClicked:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)splashAdWillDismissFullScreenModal:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
//{
//    NSLog(@"%s",__FUNCTION__);
//}
@end
