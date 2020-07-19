//
//  Header.h
//  douyutest
//
//  Created by yx on 2018/5/25.
//  Copyright © 2018年 yx. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height
#define CCPRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TABBAR_TITLE_FONT [UIFont systemFontOfSize:18.f]
#define NAV_TAB_BAR_HEIGHT 36


#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define yesheight (IS_iPhoneX ? 82:58)
#define isboheight (IS_iPhoneX ? 34:0)

#define isheight (IS_iPhoneX ? 88:64)
#define statusheight (IS_iPhoneX ? 44:20)
#define bottomheight (IS_iPhoneX ? 84:50)

#define bottomviewH 113*kScreenW/375
#define iPhoneXtabbar 88
#define noiPhoneXtabbar 64
#define Def [NSUserDefaults standardUserDefaults]




//RGB
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)

#define BorderColor  [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1]
#define PlaceholderColor [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1]
#define TextColor [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//系统版本
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]

//#define Url @"http://192.168.2.110:8080/dyk/"






#import "YXtabbarViewController.h"
#import "HOOMViewController.h"
#import "HTGViewController.h"
#import "FXViewController.h"
#import "MESViewController.h"
#import "MYViewController.h"
#import "YX-myUI.h"
#import "SDAutoLayout.h"
#import "ChanelViewController.h"
#import "XLChannelControl.h"
#import "XLChannelView.h"
#import "BaiduMobAdSDK/BaiduMobCpuInfoManager.h"
#import "BaiduMobAdSDK/BaiduMobAdCommonConfig.h"
#import <BaiduMobAdSDK/BaiduMobAdSplash.h>
#import <BaiduMobAdSDK/BaiduMobAdSetting.h>
#import <BaiduMobAdSDK/BaiduMobCpuInfoManager.h>
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "UIImage (GIF).h"
#import "Masonry.h"
#import "MHProgress.h"

#import "TodaysellVController.h"
#import "GirlCloVController.h"
#import "XieBaoVController.h"
#import "MeiZhViewController.h"
#import "BoyCloseVController.h"
#import "NeiYiViewController.h"
#import "FoodsViewController.h"
#import "JiaJJViewController.h"
#import "ShuMAVController.h"
#import "SportsViewController.h"
#import "MuYingVController.h"
#import "HHvIew.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "todayCell.h"
#import "Hdtitleview.h"
#import "MYTableViewCell.h"
#import "myheader.h"
#import "SDCycleScrollView.h"
#import "detailViewController.h"
#import "UIImageView+WebCache.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialCore/UMSocialCore.h"
#import <UShareUI/UShareUI.h>
#import "BaiduMobAdSDK/BaiduMobAdDelegateProtocol.h"
#import "BaiduMobAdSDK/BaiduMobAdSetting.h"
#import "BaiduMobAdSDK/BaiduMobAdView.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeAdView.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeAdDelegate.h"
#import "BaiduMobAdSDK/BaiduMobAdNative.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeAdObject.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeVideoView.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeWebView.h"
#import "BaiduMobAdSDK/BaiduMobAdInterstitial.h"


#import "SDTableViewController.h"
#import "MesTableViewCell.h"
#import "mmViewController.h"
#import "detailTableViewCell.h"
#import "settingViewController.h"
#import "PsoninfoViewController.h"
#import "TXSRViewController.h"
#import "shouyiViewController.h"
#import "DJSViewController.h"
#import "djsTableViewCell.h"
#import "CollectViewController.h"
#import "CollTableViewCell.h"
#import "ZujiViewController.h"
#import "GFCalendar.h"
#import "myallowerViewController.h"
#import "allowTableViewCell.h"
#import "Erweimaview.h"
#import "djsfootview.h"
#import "YPTabBarController.h"
#import "SCewmViewController.h"
#import "YqmViewController.h"
#import "fabiaoViewController.h"
#import "JRToast.h"
#import "IQKeyboardManager.h"
#import "ZYQAssetPickerController.h"
#import "logViewController.h"
#import "ScorollViewController.h"
#import "JWShareView.h"
#import "GDTSDKConfig.h"
#import "GDTNativeExpressAd.h"
#import "GDTNativeExpressAdView.h"
#import "GDTMobBannerView.h"
#import "MJRefresh.h"
#import "RegistViewController.h"
#import "changenmViewController.h"
#import "TXViewController.h"
#import "returninfoViewController.h"
#import "SGQRCode.h"
#import "XWScanImage.h"
#import "webViewController.h"
#import "fxdetailVController.h"
#import "SZKCleanCache.h"
#import "AboutweVController.h"




#endif /* Header_h */
