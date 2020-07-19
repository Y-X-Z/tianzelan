//
//  ScorollViewController.m
//  LingYuanShengLe8
//
//  Created by yx on 2017/2/10.
//  Copyright © 2017年 yx. All rights reserved.
//

#import "ScorollViewController.h"
#import "header.h"

@interface ScorollViewController ()<SDCycleScrollViewDelegate>{
    SDCycleScrollView *_headScroview;
    NSMutableArray *_imagedataArray;
}
@end
@implementation ScorollViewController
-(void)viewWillAppear:(BOOL)animated{
    [_headScroview adjustWhenControllerViewWillAppera];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHeadView];
    [self.view addSubview:_headScroview];
    _imagedataArray=[NSMutableArray array];
}
-(void)initHeadView{
    _headScroview=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,kScreenW,kScreenH) imageNamesGroup:_imagedataArray];
    _headScroview.placeholderImage=[UIImage imageNamed:@""];
    _headScroview.delegate=self;
    _headScroview.backgroundColor=[UIColor whiteColor];
    _headScroview.infiniteLoop = NO;
    _headScroview.autoScrollTimeInterval=3;
    _headScroview.pageControlStyle=SDCycleScrollViewPageContolStyleNone;
    _headScroview.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
    _imagedataArray = [NSMutableArray arrayWithObjects:@"play_1",@"play_2",@"play_3",@"play_4",nil];
    _headScroview.localizationImageNamesGroup=_imagedataArray;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;{
    if (index==3){
        YXtabbarViewController *tabbarc = [YXtabbarViewController sharedManager];
        [UIApplication sharedApplication].keyWindow.rootViewController=tabbarc;
        tabbarc.selectedIndex=0;
        MBProgressHUD*hud = [MBProgressHUD showHUDAddedTo:tabbarc.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"欢迎来到海豚社区";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:3.f];
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)inde{
    
}
@end
