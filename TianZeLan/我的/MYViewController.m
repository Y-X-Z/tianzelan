//
//  MYViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MYViewController.h"
#import "header.h"

static NSString *cellIdentifier = @"MYTableViewCell";
static NSString *COcellIdentifier = @"UICollectionViewCell";



@interface MYViewController ()<UITableViewDelegate,UITableViewDataSource,UMSocialShareMenuViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray * picImageNamesArray1;
    NSArray * NamesArray1;
    
    NSArray * picImageNamesArray2;
    NSArray * NamesArray2;
    
    NSArray * picImageNamesArray3;
    NSArray * NamesArray3;

    NSArray * Array;

    UITableView * tableView;

    JWShareView *shareView;
    JWShareItemButton *btn;
}
@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    picImageNamesArray1 = @[@"shoucang",@"zuji",@"shequ"];
    picImageNamesArray2 = @[@"dianzhu",@"yaoqingma",@"wxerwm"];
    picImageNamesArray3 = @[@"shareapp",@"dafen",@"jianyi"];
    
    NamesArray1 = @[@"我的收藏",@"我的足迹",@"我的社区"];
    NamesArray2 = @[@"邀请店主",@"邀请码",@"上传微信二维码"];
    NamesArray3 = @[@"分享APP", @"为海豚打分",@"意见反馈"];
    
    Array = @[@"daijiesuan", @"ketixian",@"shouyi",@"orderlist"];
    [self inittabview];

    
}

-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}
-(void)inittabview{
    myheader *headerview=[[myheader alloc]init];
    
    if ([Def objectForKey:@"uid"]) {
        [headerview.headimagev sd_setImageWithURL:[NSURL URLWithString:[Def objectForKey:@"iconurl"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        [headerview.personinfo setTitle:[Def objectForKey:@"name"] forState:UIControlStateNormal];
    }

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [headerview.headimagev addGestureRecognizer:tapGestureRecognizer];
    headerview.headimagev.userInteractionEnabled=YES;
   
    [headerview.seting addTarget:self action:@selector(setT) forControlEvents:UIControlEventTouchUpInside];
    [headerview.personinfo addTarget:self action:@selector(soninfo) forControlEvents:UIControlEventTouchUpInside];
    headerview.collectionview.delegate =self;
    headerview.collectionview.dataSource =self;
    [headerview.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:COcellIdentifier];
    
    
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kScreenW,kScreenH-51) style:UITableViewStyleGrouped];
    UINib *nib = [UINib nibWithNibName:@"MYTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    tableView.tableHeaderView = headerview;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorColor=[UIColor clearColor];
    tableView.backgroundColor=RGBA(242, 242, 242, 1);
    [self.view addSubview:tableView];
}
-(void)setT{
    settingViewController *setvc=[settingViewController new];
    setvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:setvc animated:YES];
}
-(void)button1{
    DJSViewController *setvc=[DJSViewController new];
    setvc.headstr=@"待结算收入";
    setvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:setvc animated:YES];
}
-(void)button2{
    TXSRViewController *setvc=[TXSRViewController new];
    setvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:setvc animated:YES];
}
-(void)button3{
    shouyiViewController *setvc=[shouyiViewController new];
    setvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:setvc animated:YES];
}
-(void)button4{
    DJSViewController *setvc=[DJSViewController new];
    setvc.headstr=@"订单列表";
    setvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:setvc animated:YES];
}
-(void)soninfo{
    if ([Def objectForKey:@"uid"]) {
        PsoninfoViewController *PsoninfoVc=[PsoninfoViewController new];
        PsoninfoVc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:PsoninfoVc animated:YES];
    }else{
        logViewController *loginview = [logViewController sharedManager];
        UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:loginview];
        nvc.navigationBar.hidden=YES;
        [UIApplication sharedApplication].keyWindow.rootViewController=nvc;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return NamesArray1.count;
            break;
        case 1:
            return NamesArray2.count;
            break;
        case 2:
            return NamesArray3.count;
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            CollectViewController *collevc=[CollectViewController new];
            collevc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:collevc animated:YES];
        }if (indexPath.row==1) {
            ZujiViewController *ZujiViewC=[ZujiViewController new];
            ZujiViewC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:ZujiViewC animated:YES];
        }if (indexPath.row==2) {
            myallowerViewController *ZujiViewC=[myallowerViewController new];
            ZujiViewC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:ZujiViewC animated:YES];
        }
    }if (indexPath.section==1) {
        if (indexPath.row==0) {
            [self click];
        }
        if (indexPath.row==1) {
            YqmViewController *ZujiViewC=[YqmViewController new];
            ZujiViewC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:ZujiViewC animated:YES];
        }
        if (indexPath.row==2) {
            SCewmViewController *ZujiViewC=[SCewmViewController new];
            ZujiViewC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:ZujiViewC animated:YES];
        }
    }
    
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            [self shareto];
        }if (indexPath.row==1){
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089336971?mt=8"]];
        } if (indexPath.row==2) {
            returninfoViewController *ZujiViewC=[returninfoViewController new];
            ZujiViewC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:ZujiViewC animated:YES];
        }
    }
    
}
/**
 errorTableViewCell 赋值
 @param tableView 表格
 @param indexPath 行数
 @return cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MYTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[MYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    if (indexPath.section==0) {
        cell.Imagename.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",picImageNamesArray1[indexPath.row]]];
        cell.name.text=[NSString stringWithFormat:@"%@",NamesArray1[indexPath.row]];
    }if (indexPath.section==1) {
        cell.Imagename.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",picImageNamesArray2[indexPath.row]]];
        cell.name.text=[NSString stringWithFormat:@"%@",NamesArray2[indexPath.row]];
    }
    if (indexPath.section==2) {
        cell.Imagename.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",picImageNamesArray3[indexPath.row]]];
        cell.name.text=[NSString stringWithFormat:@"%@",NamesArray3[indexPath.row]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=RGB(242, 242, 242);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)shareto{
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
-(void)click{
    NSArray *contentArray = @[@{@"icon":@"weixinhaoyou"},
                              @{@"icon":@"pengyouquan"},
                              @{@"icon":@"qqhaoyou"},
                              @{@"icon":@"qqkongjian"},
                              @{@"icon":@"copy"}];
    shareView = [[JWShareView alloc]init];
    [shareView addShareItems:self.tabBarController.view shareItems:contentArray selectShareItem:^(NSInteger tag, NSString *title) {
        
        switch (tag) {
            case 0:
                [self shareToPlatformType:UMSocialPlatformType_WechatSession];
                break;
            case 1:
                [self shareToPlatformType:UMSocialPlatformType_WechatTimeLine];
                break;
            case 2:
                [self shareToPlatformType:UMSocialPlatformType_QQ];
                break;
            case 3:
                [self shareToPlatformType:UMSocialPlatformType_Qzone];
                break;
            case 4:
                [self COPYURL];
                break;
            default:
                break;
        }
    }];
}
-(void)COPYURL{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"已复制";
    hud.offset = CGPointMake(0.f, 0.f);
    [hud hideAnimated:YES afterDelay:2.f];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(65,55);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10,20,10,20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

/**
 collectionView
 @param indexPath 行数
 @return cell
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COcellIdentifier forIndexPath:indexPath];
    [cell.contentView addSubview:[YX_myUI createImageViewFrame:cell.contentView.frame Image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",Array[indexPath.item]]]] ];
    return cell;
}
/**
 didSelectItemAtIndexPath 点击跳转
 @param collectionView collectionView
 @param indexPath 行数
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.item) {
        case 0:
            [self button1];
            break;
        case 1:
            [self button2];
            break;
        case 2:
            [self button3];
            break;
        case 3:
            [self button4];
            break;
        default:
            break;
    }
}
@end
