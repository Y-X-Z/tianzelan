//
//  FXViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FXViewController.h"

#import "SDTimeLineTableHeaderView.h"
#import "SDTimeLineCell.h"
#import "SDTimeLineCellModel.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"

#import "header.h"



#define kTimeLineTableViewCellId @"SDTimeLineCell"

@interface FXViewController ()<SDTimeLineCellDelegate,UITableViewDataSource,UITableViewDelegate,GDTNativeExpressAdDelegete,GDTMobBannerViewDelegate,UMSocialShareMenuViewDelegate>

//// 用于请求原生模板广告，注意:不要在广告打开期间释放!
//@property (nonatomic, retain) GDTNativeExpressAd *nativeExpressAd;
//// 返回的原生模板广告数组
//@property (nonatomic, retain) NSArray *expressAdViews;
//@property (nonatomic, strong) GDTMobBannerView *bannerView;

@end

@implementation FXViewController{
    UITableView *tableView;
    NSString *imastr;
    MBProgressHUD *hud;
}
- (void)setupRefresh{
    [tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    tableView.headerPullToRefreshText = @"下拉可以刷新了";
    tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    tableView.headerRefreshingText = @"正在帮你刷新中";
    tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableView.footerRefreshingText = @"正在帮你加载中";
}
-(void)headerRefreshing{
    //[self.nativeExpressAd loadAd:5];
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:1]];
    [tableView reloadData];
    [tableView headerEndRefreshing];
}
-(void)footerRefreshing{
    //[self.nativeExpressAd loadAd:5];
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:1]];
    [tableView reloadData];
    [tableView footerEndRefreshing];
}
- (void)viewDidLoad{
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
//    self.nativeExpressAd = [[GDTNativeExpressAd alloc]initWithAppId:@"1106479921" placementId:@"5040624802409038" adSize:CGSizeMake(kScreenW, 300)];
//    self.nativeExpressAd.delegate = self; // 例如:拉取 5 条广告
//    [self.nativeExpressAd loadAd:5];

    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];

    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight,kScreenW,kScreenH-isheight-50) style:UITableViewStyleGrouped];
    [tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nativeexpresscell"];
    tableView.dataSource=self;
    tableView.delegate=self;
    UIImageView *Imageview=[YX_myUI createImageViewFrame:CGRectMake(0, 0, kScreenW, kScreenW/3) imageName:@"image4"];
    tableView.tableHeaderView = Imageview;
    Imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage)];
    [Imageview addGestureRecognizer:tapGesturRecognizer];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    tableView.separatorColor=[UIColor groupTableViewBackgroundColor];
    tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableView];

    // 解决在iOS11上朋友圈demo文字收折或者展开时出现cell跳动问题
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    
    [self.view addSubview:[YX_myUI createButtonWithFrame:CGRectMake(kScreenW-50, kScreenH-bottomheight-50, 40, 40) Target:self Selector:@selector(fabiao) Image:@"FABIAO" ImagePressed:@"FABIAO"]];
    
    [self setupRefresh];
    
}
-(void)tapPage{
    id<AlibcTradePage> page = [AlibcTradePageFactory page:@"https://s.click.taobao.com/kVgLzPw"];
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    showParams.openType = AlibcOpenTypeNative;
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = nil;
    [service
     show:showParams.isNeedPush ? self.navigationController : self
     page:page
     showParams:showParams
     taoKeParams:taokeParams
     trackParam:nil
     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
         //NSLog(@"于翔的订单号=%@",result.payResult.paySuccessOrders);
         
     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
         //NSLog(@"于翔的error=%@",error);
     }];
}
-(void)fabiao{
    fabiaoViewController *fabiaoView=[fabiaoViewController new];
    fabiaoView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fabiaoView animated:YES];
}
- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     @"icon5.jpg",
                                     @"icon6.jpg",
                                     @"icon7.jpg",
                                     ];
    
    NSArray *namesArray = @[@"科比绝伦",
                            @"小脑斧",
                            @"好名都被狗起了",
                            @"巭孬",
                            @"爵士容颜",
                            @"我的小傻瓜",
                            @"德玛西亚之力",
                            @"铠皇",
                            @"后羿",
                            @"瑞雯"];
    
    NSArray *textArray = @[
                           @"“一带一路”和上海合作组织有着天然的联系。上合组织成员国、观察员国和对话伙伴国都位于“一带一路”沿线。2013年9月，习近平首次亮相上合峰会就指出：“上海合作组织6个成员国和5个观察员国都位于古丝绸之路沿线。",
                           @"央视网消息：2018年是中国提出“一带一路”倡议五周年，上海合作组织是“一带一路”倡议的积极支持者和践行者，是欧亚经济联盟和丝绸之路经济带对接的一个非常重要的平台。中国大力推动“一带一路”建设同各国发展战略对接，为上海合作组织各国创造更多合作机遇",
                           @"截至6月5日，已有21个省(区、市)陆续发布了2017年城镇单位就业人员平均工资数据。从已公布的数据看，随着我国供给侧结构性改革深入推进，经济发展新动能加快成长，企业生产经营环境明显改善，城镇单位就业人员平均工资也实现了稳步增长。",
                           @"今年第4号台风“艾云尼”第三次登陆 中国华南局地暴雨超400毫米中新社北京6月7日电 (记者 陈溯)中央气象台7日消息，今年第4号台风正式获得命名“艾云尼”，预计7日下午至夜间将再次登陆广东。",
                           @"针对近期有报道称“一带一路”项目增加了沿线国家的债务。商务部新闻发言人高峰今天回应称，中国从来不做凌驾于人的强买强卖，“一带一路”项目给沿线国家带去的不是负担，而是希望和发展。",
                           @"新华社北京6月13日电 国务院日前印发《关于建立企业职工基本养老保险基金中央调剂制度的通知》（以下简称《通知》），决定建立养老保险基金中央调剂制度，自2018年7月1日起实施。",
                           @"在“人人都有麦克风”的时代，一些个性十足的表达方式在网络上层出不穷，折射出年轻网民活跃多样的思想观念，与他们求新求变的特点互为表里。但近来，所谓“跪求体”“哭晕体”在一些网络媒体的标题、正文中频频出现，其浮夸荒诞的文风，却令不少读者感到不适。",
                           @"【文/观察者网李焕宇】即便接收了国际货币基金组织（IMF）给出的最大规模贷款——500亿美元，阿根廷比索仍然在下跌，其兑美元汇率创出26.009的历史最低位。为加强自身对外汇市场的掌控力，阿政府想向中国求助。6月11日，阿根廷《金融界报》报道称，阿根廷央行希望将其与中国央行签署的货币互换协议额度提高30%-50%，即最多提高50亿美元。",
                           @"云南勐海县坠落陨石年龄和太阳系相当 最贵的一块卖到16万元,最终，中科院紫金山天文台的专家为这次坠落的陨石验明了“正身”，称这是目前中国最“及时”的陨石雨，深藏太阳系的秘密。此外，记者还了解到，有人以16万元的收购价将一颗1.6斤重的陨石收入囊中，这是当地村民手中价格卖得最高的一块陨石。",
                           @"本报讯（记者 李天际）从建国门到复兴门、从鼓楼到地安门、从前门到永定门、从金融街到CBD……同样的位置，不同的年代，1000余幅今昔对比的图片再现北京的城市变迁。昨日起，“时光如烟 古都巨变”辉煌四十年影像记忆展览在北京市城市建设档案馆拉开帷幕。"
                           ];
    
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"0.jpg",
                                     @"1.jpg",
                                     @"2.jpg",
                                     @"3.jpg",
                                     @"4.jpg",
                                     @"5.jpg",
                                     @"6.jpg",
                                     @"7.jpg",
                                     @"8.jpg",
                                     @"9.jpg",
                                     @"10.jpg",
                                     @"11.jpg",
                                     @"12.jpg",
                                     @"13.jpg",
                                     @"14.jpg",
                                     @"15.jpg",
                                     @"16.jpg",
                                     @"17.jpg",
                                     @"18.jpg",
                                     @"19.jpg",
                                     @"20.jpg",
                                     @"21.jpg",
                                     @"22.jpg",
                                     @"23.jpg",
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(8);
        int nameRandomIndex = arc4random_uniform(10);
        int contentRandomIndex = arc4random_uniform(10);
        
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(23);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        [resArr addObject:model];
    }
    return [resArr copy];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = nil;
//    if (indexPath.row % 2 == 0) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"nativeexpresscell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
//        if ([subView superview]) {
//            [subView removeFromSuperview];
//        }
//        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
//        view.tag = 1000;
//        [cell.contentView addSubview:view];
//        return cell;
//    } else {
//        SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
//        cell.indexPath = indexPath;
//        __weak typeof(self) weakSelf = self;
//        if (!cell.moreButtonClickedBlock) {
//            [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
//                SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
//                model.isOpening = !model.isOpening;
//                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            }];
//            cell.delegate = self;
//        }
//        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
//        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
//        cell.model = self.dataArray[indexPath.row];
//        return cell;
//    }
//    return 0;
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        cell.delegate = self;
    }
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.botview.sharebtn.tag = indexPath.row;
    [cell.botview.sharebtn addTarget:self action:@selector(shareto:) forControlEvents:UIControlEventTouchUpInside];
    [cell.botview.zanbtn setTitle:[NSString stringWithFormat:@" %u",1+(arc4random() % 10)] forState:UIControlStateNormal];
    [cell.botview.replybtn setTitle:[NSString stringWithFormat:@" %u",1+(arc4random() % 10)] forState:UIControlStateNormal];
    [cell.botview.zanbtn addTarget:self action:@selector(zanto:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row % 2 == 0) {
//        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
//        return view.bounds.size.height;
//    }
//    else {
//        id model = self.dataArray[indexPath.row];
//        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
//    }
    id model = self.dataArray[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    fxdetailVController *faxianvc=[fxdetailVController new];
    faxianvc.hidesBottomBarWhenPushed=YES;
    faxianvc.model=_dataArray[indexPath.row];
    [self.navigationController pushViewController:faxianvc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.expressAdViews.count * 2;
    return _dataArray.count;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    _bannerView = [[GDTMobBannerView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 150) appId:@"1106899633" placementId:@"4090812164690039"];
//    _bannerView.delegate = self; // 设置Delegate
//    _bannerView.currentViewController = self; //设置当前的ViewController
//    _bannerView.interval = 3; //【可选】设置刷新频率;默认30秒
//    _bannerView.isGpsOn = NO; //【可选】开启GPS定位;默认关闭
//    _bannerView.showCloseBtn = YES; //【可选】展示关闭按钮;默认显示
//    _bannerView.isAnimationOn = YES; //【可选】开启banner轮播和展现时的动画效果;默认开启
//    _bannerView.hidden = NO;
//    [_bannerView loadAdAndShow]; //加载广告并展示
//    return _bannerView;
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

//#pragma mark - GDTNativeExpressAdDelegete
///**
// * 拉取广告成功的回调
// */
//- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views
//{
//    self.expressAdViews = [NSArray arrayWithArray:views];
//    if (self.expressAdViews.count) {
//        [self.expressAdViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            GDTNativeExpressAdView *expressView = (GDTNativeExpressAdView *)obj;
//            expressView.controller = self;
//            [expressView render];
//        }];
//    }
//    [tableView reloadData];
//}
//
///**
// * 拉取广告失败的回调
// */
//- (void)nativeExpressAdRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView
//{
//}
//
///**
// * 拉取原生模板广告失败
// */
//- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error
//{
//    NSLog(@"Express Ad Load Fail : %@",error);
//}
//
//- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView
//{
//    [tableView reloadData];
//}
//
//- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView
//{
//
//}
//
//- (void)nativeExpressAdViewClosed:(GDTNativeExpressAdView *)nativeExpressAdView
//{
//    NSLog(@"--------%s-------",__FUNCTION__);
//
//
//}

-(void)shareto:(UIButton*)sender{
    _model1 = _dataArray[sender.tag];
    if (_model1.picNamesArray.count>0) {
        imastr=[_model1.picNamesArray objectAtIndex:0];
    }else{
        imastr=@"head";
    }
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager setShareMenuViewDelegate:self];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (platformType==UMSocialPlatformType_WechatSession) {
            [self shareToPlatformType:platformType withstr:self->_model1.msgContent andimagestr:self->imastr];
        }if (platformType==UMSocialPlatformType_WechatTimeLine) {
            [self shareToPlatformType:platformType withstr:self->_model1.msgContent andimagestr:self->imastr];
        }if (platformType==UMSocialPlatformType_QQ) {
            [self shareToPlatformType:platformType withstr:self->_model1.msgContent andimagestr:self->imastr];
        }if (platformType==UMSocialPlatformType_Qzone) {
            [self shareToPlatformType:platformType withstr:self->_model1.msgContent andimagestr:self->imastr];
        }
    }];
}
- (void)shareToPlatformType:(UMSocialPlatformType)platformType withstr:(NSString *)labelstr andimagestr:(NSString *)imagestr{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"小海豚来报信了" descr:labelstr thumImage:[UIImage imageNamed:imagestr]];
    shareObject.webpageUrl =@"http://www.tianzelan.com";
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            self->hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            self->hud.mode = MBProgressHUDModeText;
            self->hud.label.text = @"感谢您的分享";
            self->hud.offset = CGPointMake(0.f, 0.f);
            [self->hud hideAnimated:YES afterDelay:2.f];
        }
    }];
}
-(void)zanto:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected) {
        [sender setTitle:[NSString stringWithFormat:@" %ld",[sender.titleLabel.text integerValue]+1] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"dzan"] forState:UIControlStateSelected];
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"已点赞";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:1.f];
    }else{
        [sender setTitle:[NSString stringWithFormat:@" %ld",[sender.titleLabel.text integerValue]-1] forState:UIControlStateNormal];
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"已取消点赞";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:1.f];
    }
}
@end
