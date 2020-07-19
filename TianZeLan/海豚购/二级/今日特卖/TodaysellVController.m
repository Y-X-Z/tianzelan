//
//  TodaysellVController.m
//  TianZeLan
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "TodaysellVController.h"
#import "header.h"

static NSString *cellIdentifier = @"todayCell";

@interface TodaysellVController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
{
    UIView *headerview;
    UIImageView *headimagev;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIImageView *laimagev;
    UICollectionView *NormalCollection;
    HHvIew *cusview;
    SDCycleScrollView *_headScroview;
    NSArray * imageArray;
    NSArray * urlArray;
    
    NSArray * imagearr;
    NSArray * titlearr;
    NSArray * nowpricearr;
    NSArray * sellnumarr;
    NSArray * youhuiquanarr;
    NSArray * quanhouarr;
    NSArray * urlarr;

    
}
@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;
@end

@implementation TodaysellVController

- (void)viewDidLoad {
    [super viewDidLoad];

    imagearr = [NSArray array];
    titlearr = [NSArray array];
    nowpricearr=[NSArray array];
    sellnumarr=[NSArray array];
    youhuiquanarr=[NSArray array];
    quanhouarr=[NSArray array];
    imageArray=[NSArray array];
    urlArray=[NSArray array];
    urlarr=[NSArray array];
    
    [self MAKEui];
    [self loaddata];
}
-(void)loaddata{
    
    urlarr= [NSArray arrayWithObjects:
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.11.23d149c9tcZeib&e=6o%2Bs9yh1dbwGQASttHIRqQsdJUcPhDFDH86WM5YUpvDyi1aSyqbpmjC4KB0X%2FR25GcwOq0wiGrSfMuQNWPI4IXXPVg0l41fybd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.1.23d149c9tcZeib&e=b%2BDTe0izm6oGQASttHIRqYr%2FfyOoKxWZ2Bfdc0zE0FMh4%2FBFCEkLWJOk2rP7jD5oGDHrzfgsWoCEyeAosMUOIbehFi35Dmyqbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.2.23d149c9tcZeib&e=rqMCUbjrRAUGQASttHIRqdwdACON7vgBMjB6L7uFAuim%2FPqYSC%2BIlh%2F%2FKwnuvaDikmaRmWkjKNQiV4bPJn1DBSP3QxD4kWmKbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.12.23d149c9tcZeib&e=RmAULo6U0fEGQASttHIRqRNIStUyTiMPn6fL%2FHHkp8Hl43M3mIB1t4yZY0PYomO1tXX5EMflUVgKsrd5edazYEOnGX3QGofUbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.3.23d149c9tcZeib&e=fARuXdlhq8gGQASttHIRqRWbwUUP%2FBPzFe0NZszykWuOOynoqP64GVZZ3cAydfcKCTD7buS7Kom1M7ncg54TLqESRNqSjTR1bd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.13.23d149c9tcZeib&e=FQzscC2WY0EGQASttHIRqRSsBnkeG4N9AnYd8lPHvK7SJ8DRB%2BFABYtBia3ym1Nozn3EEmY2Qrq%2FdounO%2FBULLhSgc8Hgf2Cbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.4.23d149c9tcZeib&e=pOhctq30YPwGQASttHIRqSblt9bfRgWWvVwZSEWaLrHGVWvbOqykrmYRJbarWPzZR2VsrnorCIb0McJjIwxK63deNsnFCutYbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.14.23d149c9tcZeib&e=JVLUaTr4INYGQASttHIRqScXu0CDbOCLLhiW3VyrwJeAnVXUwZx8IgkbPCEhU%2F7mLObk3BYIgRebNkpgUq%2FSIV5D64aM5cKpbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.5.23d149c9tcZeib&e=w5q79qzQLSsGQASttHIRqRRaW0nCvx8zVG3PirNuRc5Um%2Fg8xRLmNmISqN%2FZ5dHzZ4snsKMtcJnRtsAWkeO3KWiJd1fnSiOUbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.15.23d149c9tcZeib&e=3b%2BpRrGum0wGQASttHIRqcJDynlwA8CU%2FrKp%2BH29NYWJBiHzvBsckVmy8WzQmIZAKrvBpem8px6h%2BR9G7Z2sTooqv%2F0%2Bp3wjbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.6.23d149c9tcZeib&e=szOHl2zEn4MGQASttHIRqbXkkiuHutN1rTEoKGqT5F7SJ8DRB%2BFABWBfK0Tbu7tLWT5uHhbWyArokL7cvzqxl2J7Tnse0MELbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.16.23d149c9tcZeib&e=FTP2J9NR2oYGQASttHIRqXKQPZieAmFxMcqFIfIDIZzeQisExutkD1QdUeLY8rSd4ZgJUSFhPmtBRvUqoTOsOX8HNY8eSBV5bd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.7.23d149c9tcZeib&e=rtGFMpYdypcGQASttHIRqTgFdjBtlaUg03ko%2FYsCpmwYXB958FVfbGhTsI1OFNGKrymwQ9rordm5UtPrSMpfiEe9WKEJGfQ%2Bbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.17.23d149c9tcZeib&e=wqs0gFLrpQkGQASttHIRqYcU6iM7elnZnsJk5Pvk%2FwreQisExutkD1rwem8i0WapOKmHpHaR0LnGP1AzildEl3PrhIU9tegZbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.8.23d149c9tcZeib&e=dQTQ8U%2FP52oGQASttHIRqRBogSwirEsxIXUwMB3XPv1Um%2Fg8xRLmNvoGXl3nrGj749iQSlq43pYEL58af5dSTLa8PTcmw14vbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.18.23d149c9tcZeib&e=27POMNR%2BO4QGQASttHIRqWKQY7MjCdZaX1Ntma1L86%2BEdvD4wwM%2BY73pFa9Azc%2BZXBymrrjpoBQ6fLdAZDu8i42sTXYoCSgGbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.9.23d149c9tcZeib&e=92jZBZmZMAYGQASttHIRqU8EisxAjHpCXpf1Hi7yTKLeQisExutkD9X4pyuFo8rTDqreGk4L9xHzJtaW1TJpCS8Hc3QxtwQ8bd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.19.23d149c9tcZeib&e=d73I8dHGyCMGQASttHIRqbKSzbfMyCURRrYU3e0P8YvGVWvbOqykrolielc2w948uKIgYsjVyrgw%2F62nLV7oACs50rF8wwCTbd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.10.23d149c9tcZeib&e=auHccZLNQAsGQASttHIRqamkjROQBMQKjredGGV3JsUYXB958FVfbI5WJj4XSv3zSBpEhEA6du6IaGS2GGKOx7fYInPkEan7bd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch",
             @"https://uland.taobao.com/coupon/edetail?spm=a3126.7792474/a.1005.20.23d149c9tcZeib&e=98PzRIyruOAGQASttHIRqaBdnt8GABMnoYMYyyJR0YSm%2FPqYSC%2BIlq8aifZLMlyOtJgVFoyVyqKgtLEmse3s2AaLtw4Cl6Iibd76m3V5xpZXU1Kz1isrxvLicJbJjm2FEgbXsunDX5QgMEBxcHG%2BuG%2BCnDIEMzEj&mt=1&ptl=bucket:_TL-43223;prepvid:a3126.7792474/a_1528264452866_7699849613382898;engpvid:100_10.103.67.63_17892_5541528264452991238;from:temaisearch", nil];
    
    imagearr = [NSArray arrayWithObjects:
                @"https://img.alicdn.com/imgextra/i3/2364252554/TB2FSswXpuWBuNjSspnXXX1NVXa_!!2364252554.jpg_430x430q90.jpg",
                @"https://img.alicdn.com/imgextra/i2/2255608987/TB1UZl9vVOWBuNjy0FiXXXFxVXa_!!0-item_pic.jpg_q30.jpg",
                @"https://gd1.alicdn.com/imgextra/i2/2863110488/TB2r465h4TI8KJjSspiXXbM4FXa_!!2863110488.jpg_400x400.jpg",
                @"https://img.alicdn.com/bao/uploaded/i2/760732044/TB1a89_gRjTBKNjSZFNXXasFXXa_!!0-item_pic.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/imgextra/i2/3525305592/TB1o.l.bAfb_uJkSmRyXXbWxVXa_!!0-item_pic.jpg_430x430q90.jpg",
                @"https://img.alicdn.com/bao/uploaded/i5/TB1845Jakfb_uJkSmLy32ZxoXXa_105555.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/bao/uploaded/i3/3417158864/TB1B2CemeGSBuNjSspbXXciipXa_!!0-item_pic.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/bao/uploaded/i4/2452522090/TB2w7WkjXuWBuNjSspnXXX1NVXa_!!2452522090.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/bao/uploaded/i2/170740318/TB2a0Xuuk9WBuNjSspeXXaz5VXa_!!170740318-0-item_pic.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/bao/uploaded/i2/1586068427/TB2rY5FoKOSBuNjy0FdXXbDnVXa_!!1586068427-0-item_pic.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/bao/uploaded/i3/908483460/TB12zcWvH5YBuNjSspoXXbeNFXa_!!0-item_pic.jpg_300x300q90.jpg",
                @"https://gaitaobao1.alicdn.com/tfscom/i2/2123013687/TB20ZDhvaSWBuNjSsrbXXa0mVXa_!!2123013687-0-item_pic.jpg_300x300q90.jpg",
                @"https://gaitaobao3.alicdn.com/tfscom/i3/3356954513/TB26kJTtN9YBuNjy0FfXXXIsVXa_!!3356954513-0-item_pic.jpg_300x300q90.jpg",
                @"https://gaitaobao1.alicdn.com/tfscom/i3/2448997722/TB28BflgL6TBKNjSZJiXXbKVFXa_!!2448997722.jpg_300x300q90.jpg",
                @"https://img.alicdn.com/imgextra/i2/1791648946/TB1R1Zhd7OWBuNjSsppXXXPgpXa_!!0-item_pic.jpg_430x430q90.jpg",
                @"https://gaitaobao1.alicdn.com/tfscom/i4/2933336379/TB2mXHCuH5YBuNjSspoXXbeNFXa_!!2933336379-0-item_pic.jpg_300x300q90.jpg",
                @"https://gaitaobao4.alicdn.com/tfscom/i4/TB1v.TrQVXXXXabaFXXXXXXXXXX_!!0-item_pic.jpg_300x300q90.jpg",
                @"https://gaitaobao4.alicdn.com/tfscom/i3/2879319564/TB2NLrZbHuWBuNjSszgXXb8jVXa_!!2879319564.jpg_300x300q90.jpg",
                @"https://gaitaobao1.alicdn.com/tfscom/i4/1579510920/TB2WidCrwmTBuNjy1XbXXaMrVXa_!!1579510920-0-item_pic.jpg_300x300q90.jpg",
                @"https://gaitaobao3.alicdn.com/tfscom/i4/678348281/TB2rJbytohnpuFjSZFpXXcpuXXa_!!678348281.jpg_300x300q90.jpg", nil];
    
    titlearr = [NSArray arrayWithObjects:@"润盈敏+500亿活性益生菌粉儿童成人冻干粉固体饮料含益生元36条",@"空调挡风板坐月子导风板出风口冷气防直吹挡板风向伸缩通用遮风板",@"诺必行婴宝护肤霜13.5g 婴儿湿痒红屁屁护臀膏无激素特护膏",@"瘦脸神器V脸瘦脸仪脸部滚轮按摩器瘦咬肌面部美容仪双下巴美容棒",@"义鼎森时尚百搭潮流纯色竹节棉打底青年男圆领套头短袖T恤男透气",@"买2发7】汤臣倍健健力多R氨糖软骨素钙片 1.02g/片*40片*3瓶套餐",@"正品情侣休闲鞋NB574男鞋女鞋运动复古新百倫连锁有限公司跑步鞋",@"嗨棒运动饮料bigbang含气瓜拉纳复合果味中粮网红功能性能量饮料",@"果本坚果电视剧同款套装女全家福礼盒深层补水保湿化妆品套装",@"孔艺夏季男鞋子飞织透气网鞋男士休闲运动潮鞋百搭网布面平底男鞋",@"纳诺儿童牙膏宝宝可吞咽无氟护龈防蛀分阶2-5-6-12岁4支装送牙刷",@"希思尼2018夏季新款拼色小白鞋女休闲鞋文艺牛皮鞋平底单鞋9909",@"桂甄堂每日坚果混合付爱宝系列成人儿童孕妇休闲零食两盒24包",@"花花公子短袖衬衫男2018春季新薄款免烫竖条纹男士上衣休闲",@"朵朵雪防晒衣女连帽中长款2018春夏新款女装韩版字母上衣防晒服女",@"纤缤品牌大码女装夏季新品时尚气质包臀小礼服缎面雪纺连衣裙子",@"朵朵雪防晒衣女中长款2018春夏新款宽松连帽防晒服大码女装外套女",@"前任3林佳同款海豚鱼尾吊坠925纯银项链锁骨链饰品学生生日礼物女",@"递欧速干眼线笔初学者大眼定妆持久防汗不晕染不脱色防水眼线液笔",@"攀越者户外腰包跑步手机腰包男女运动多功能贴身隐形超轻时尚小包", nil];
    
    nowpricearr = [NSArray arrayWithObjects:@"现价￥189",@"现价￥55",@"现价￥29.9",@"现价￥59.9",@"现价￥29.9",@"现价￥149",@"现价￥148",@"现价￥39.9",@"现价￥449",@"现价￥59.9",@"现价￥86",@"现价￥168",@"现价￥49.9",@"现价￥129",@"现价￥99",@"现价￥198",@"现价￥79",@"现价￥55",@"现价59.9￥",@"现价￥26.8", nil];
    
    sellnumarr = [NSArray arrayWithObjects:@"已售1073",@"已售2.92万",@"已售1698",@"已售264",@"已售1191",@"已售220",@"已售295",@"已售2.12万",@"已售58",@"已售5723",@"已售477",@"已售48",@"已售2389",@"已售340",@"已售150",@"已售57",@"已售97",@"已售1156",@"已售594",@"已售1.03万", nil];
    
    youhuiquanarr = [NSArray arrayWithObjects:@"40元优惠券",@"30元优惠券",@"10元优惠券",@"40元优惠券",@"10元优惠券",@"50元优惠券",@"50元优惠券",@"10元优惠券",@"100元优惠券",@"30元优惠券",@"20元优惠券",@"50元优惠券",@"10元优惠券",@"50元优惠券",@"30元优惠券",@"50元优惠券",@"30元优惠券",@"30元优惠券",@"30元优惠券",@"10元优惠券", nil];
    
    quanhouarr = [NSArray arrayWithObjects:@"￥149",@"￥25",@"￥19.9",@"￥19.9",@"￥19.9",@"￥99",@"￥98",@"￥29.9",@"￥349",@"￥29.9",@"￥66",@"￥118",@"￥39.9",@"￥79",@"￥69",@"￥148",@"￥49",@"￥25",@"￥29.9",@"￥16.8", nil];
   
}
-(void)MAKEui{

    headerview = [YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 400) Backgroundcolor:RGBA(241, 241, 241, 1)];
    
    imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"image1"],[UIImage imageNamed:@"image2"],[UIImage imageNamed:@"image3"],[UIImage imageNamed:@"image4"],[UIImage imageNamed:@"image5"],[UIImage imageNamed:@"image6"], nil];
    
    urlArray = [NSArray arrayWithObjects:
                @"https://s.click.taobao.com/OCmLzPw",
                @"https://s.click.taobao.com/3zhLzPw",
                @"https://s.click.taobao.com/TciLzPw",
                @"https://s.click.taobao.com/kVgLzPw",
                @"https://s.click.taobao.com/nZNLzPw",
                @"https://s.click.taobao.com/GHLLzPw", nil];
 
    _headScroview=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,kScreenW,150) imageNamesGroup:imageArray];
    _headScroview.placeholderImage=[UIImage imageNamed:@"no_image.9"];
    _headScroview.delegate=self;
    _headScroview.autoScrollTimeInterval=3;
    _headScroview.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headScroview.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
    
    cusview=[[HHvIew alloc]init];
    cusview.frame=CGRectMake(0, 150, kScreenW, 260);
    [cusview.button1 addTarget:self action:@selector(button1click) forControlEvents:UIControlEventTouchUpInside];
    [cusview.button2 addTarget:self action:@selector(button2click) forControlEvents:UIControlEventTouchUpInside];
    [cusview.button3 addTarget:self action:@selector(button3click) forControlEvents:UIControlEventTouchUpInside];
    [cusview.button4 addTarget:self action:@selector(button4click) forControlEvents:UIControlEventTouchUpInside];

    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc] init];
    NormalCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0,kScreenW,kScreenH-isheight-bottomheight)collectionViewLayout:flow];
    NormalCollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UINib *cellNib=[UINib nibWithNibName:@"todayCell" bundle:nil];
    flow.sectionInset =UIEdgeInsetsMake(0,10, 0, 10);
    flow.headerReferenceSize =CGSizeMake(kScreenW,headerview.frame.size.height);//头视图大小
    [NormalCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview"];  //  一定要设
    
    [NormalCollection registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    NormalCollection.delegate = self;
    NormalCollection.dataSource = self;
    [self.view addSubview:NormalCollection];
 
}
-(void)button1click{
    NSString *strurl=@"https://s.click.taobao.com/63vKzPw";
    id<AlibcTradePage> page = [AlibcTradePageFactory page:strurl];
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
-(void)button2click{
    NSString *strurl=@"https://s.click.taobao.com/9n6JzPw";
    id<AlibcTradePage> page = [AlibcTradePageFactory page:strurl];
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
-(void)button3click{
    NSString *strurl=@"https://s.click.taobao.com/iDqIzPw";
    id<AlibcTradePage> page = [AlibcTradePageFactory page:strurl];
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
-(void)button4click{
    NSString *strurl=@"https://s.click.taobao.com/fUWHzPw";
    id<AlibcTradePage> page = [AlibcTradePageFactory page:strurl];
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW-20)/2,(kScreenW-20)*26/34);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5,5,5,5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return 20;
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
    todayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.titlelabel.text=[NSString stringWithFormat:@"%@",titlearr[indexPath.item]];
    cell.xiaoliang.text=[NSString stringWithFormat:@"%@",sellnumarr[indexPath.item]];
    cell.quanhoujia.text=[NSString stringWithFormat:@"券后价:%@",quanhouarr[indexPath.item]];
    cell.nowpricelabel.text=[NSString stringWithFormat:@"%@",nowpricearr[indexPath.item]];
    cell.youhuiquan.text=[NSString stringWithFormat:@"%@",youhuiquanarr[indexPath.item]];
    [cell.headimagev sd_setImageWithURL:[NSURL URLWithString:imagearr[indexPath.item]] placeholderImage:[UIImage imageNamed:@"no_image.9"]];
    return cell;
}
/**
 didSelectItemAtIndexPath 点击跳转
 @param collectionView collectionView
 @param indexPath 行数
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    detailViewController *WEBV=[[detailViewController alloc]init];
    WEBV.urlstr=[NSString stringWithFormat:@"%@",urlarr[indexPath.item]];
    id<AlibcTradePage> page = [AlibcTradePageFactory page:[NSString stringWithFormat:@"%@",urlarr[indexPath.item]]];

    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    showParams.openType = AlibcOpenTypeAuto;
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    taokeParams.pid = @"mm_26819488_41416491_179918371";
    
    NSInteger ret=[service show:WEBV webView:WEBV.WebView page:page showParams:showParams taoKeParams:taokeParams trackParam:nil tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];

    if (ret == 1) {
        WEBV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:WEBV animated:YES];
    }
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView*headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview" forIndexPath:indexPath];
    for (UIView *view in headerview.subviews) {
        [view removeFromSuperview];
    }
    [headerview addSubview:_headScroview];
    [headerview addSubview:cusview];
    return headerview;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    id<AlibcTradePage> page = [AlibcTradePageFactory page:[NSString stringWithFormat:@"%@",urlArray[index]]];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
