//
//  YXtabbarViewController.m
//  LingYuanShengLe8
//
//  Created by yx on 2017/2/15.
//  Copyright © 2017年 yx. All rights reserved.
//

#import "YXtabbarViewController.h"
#import "header.h"


@interface YXtabbarViewController ()
{
    UIImageView *loadimagev;
    UIView *Loadview;
}

@end

@implementation YXtabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self makePAGES];
    [self makemove];

    [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:5];
   
}
- (void)removeAdImageView{
    if (Loadview) {
        [UIView animateWithDuration:2.0f animations:^{
            self->loadimagev.transform = CGAffineTransformMakeScale(0.2f,0.5f);
            self->loadimagev.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self->Loadview removeFromSuperview];
        }];
    }
}
-(void)makemove{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"htmove" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    loadimagev = [YX_myUI createImageViewFrame:CGRectMake(0, kScreenH/2-kScreenW/2*0.75, kScreenW, kScreenW*0.75) Image:image];
    Loadview = [YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) Backgroundcolor:[UIColor whiteColor]];
    [Loadview addSubview:loadimagev];
    [self.view addSubview:Loadview];
}
/**
 YXtabbarViewController
 主控制器
 @return sharedManager
 */
+ (YXtabbarViewController *)sharedManager{
    static YXtabbarViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)makePAGES{
    self.tabBar.backgroundColor=[UIColor whiteColor];

    HOOMViewController *home=[[HOOMViewController alloc]init];
    UINavigationController *homenvc=[[UINavigationController alloc]initWithRootViewController:home];
    home.view.backgroundColor=[UIColor whiteColor];
    [homenvc setNavigationBarHidden:YES];
    home.tabBarItem.title=@"资讯";
    
    [home.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1.5)];
    [home.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, -1, 0)];
    [home.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(102,102,102,1)} forState:UIControlStateNormal];
     [home.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(237,43,54,1)} forState:UIControlStateSelected];
   
    
    home.tabBarItem.selectedImage = [[UIImage imageNamed:@"zixun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    home.tabBarItem.image = [[UIImage imageNamed:@"unzixun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HTGViewController *HTG=[[HTGViewController alloc]init];
    UINavigationController *HTGvc=[[UINavigationController alloc]initWithRootViewController:HTG];
    [HTGvc setNavigationBarHidden:YES];
    HTG.view.backgroundColor=[UIColor whiteColor];
    HTG.tabBarItem.title=@"海豚购";
    [HTG.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1.5)];
    [HTG.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, -1, 0)];
    [HTG.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(102,102,102,1)} forState:UIControlStateNormal];
    [HTG.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(237,43,54,1)} forState:UIControlStateSelected];
    HTG.tabBarItem.selectedImage = [[UIImage imageNamed:@"haitun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HTG.tabBarItem.image = [[UIImage imageNamed:@"unhaitun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FXViewController *QQ=[[FXViewController alloc]init];
    UINavigationController *QQvc=[[UINavigationController alloc]initWithRootViewController:QQ];
    [QQvc setNavigationBarHidden:YES];
    QQ.tabBarItem.title=@"发现";
    QQ.view.backgroundColor=[UIColor whiteColor];
    [QQ.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1.5)];
    [QQ.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, -1, 0)];
    [QQ.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(102,102,102,1)} forState:UIControlStateNormal];
    [QQ.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(237,43,54,1)} forState:UIControlStateSelected];
    QQ.tabBarItem.selectedImage = [[UIImage imageNamed:@"faxian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    QQ.tabBarItem.image = [[UIImage imageNamed:@"unfaxian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MESViewController *tips=[[MESViewController alloc]init];
    UINavigationController *tipsvc=[[UINavigationController alloc]initWithRootViewController:tips];
    [tipsvc setNavigationBarHidden:YES];
    tips.tabBarItem.title=@"消息";
    tips.view.backgroundColor=[UIColor whiteColor];
    [tips.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1.5)];
    [tips.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, -1, 0)];
    [tips.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(102,102,102,1)} forState:UIControlStateNormal];
    [tips.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(237,43,54,1)} forState:UIControlStateSelected];
    tips.tabBarItem.selectedImage = [[UIImage imageNamed:@"mes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tips.tabBarItem.image = [[UIImage imageNamed:@"unmes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    MYViewController *me=[[MYViewController alloc]init];
    UINavigationController *mevc=[[UINavigationController alloc]initWithRootViewController:me];
    [mevc setNavigationBarHidden:YES];
    me.tabBarItem.title=@"我的";
    me.view.backgroundColor=[UIColor whiteColor];
    [me.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1.5)];
    [me.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, -1, 0)];
    [me.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(102,102,102,1)} forState:UIControlStateNormal];
    [me.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(237,43,54,1)} forState:UIControlStateSelected];
    me.tabBarItem.selectedImage = [[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    me.tabBarItem.image = [[UIImage imageNamed:@"unme"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.viewControllers = @[homenvc,HTGvc,QQvc,tipsvc,mevc];
}

@end
