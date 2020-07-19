//
//  HOOMViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HOOMViewController.h"
#import "header.h"
#import "UIImage+GIF.h"


#pragma mark - 宏定义

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))/** 随机色  */

static CGFloat const titleH = 44;/** 文字高度  */

static CGFloat const MaxScale = 1.2;/** 选中文字放大  */

@interface HOOMViewController ()<UISearchBarDelegate,UIScrollViewDelegate>
{
    NSMutableArray *array;
    NSMutableArray *idarray;
    NSMutableArray *idarr;
    NSDictionary * iddic;
    UIButton *button;
    MBProgressHUD *hud;
    NSInteger selectindex;
    webViewController *vc;
    
    
    
    
    
}

@property (nonatomic, strong) WKWebView   *webView; //展示内容联盟用的webview
@property (weak, nonatomic) IBOutlet UIImageView *htimagev;
@property (weak, nonatomic) IBOutlet UIView *headview;
@property(nonatomic,strong)NSMutableArray *channelarr;


/** 文字scrollView  */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/** 控制器scrollView  */
@property (nonatomic, strong) UIScrollView *contentScrollView;
/** 标签文字  */
@property (nonatomic ,strong) NSMutableArray * titlesArr;
/** 标签按钮  */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 选中的按钮  */
@property (nonatomic ,strong) UIButton * selectedBtn;
/** 选中的按钮背景图  */
@property (nonatomic ,strong) UIImageView * imageBackView;


@end

@implementation HOOMViewController

#pragma mark lazy loading
- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}


//-(NSArray *)titlesArr
//{
//
//    if (!_titlesArr) {
//        _titlesArr  = [NSArray arrayWithObjects:@"推荐",@"本地",@"视频",@"体育",@"娱乐",@"美女",@"时尚",@"母婴",@"健康",@"女人",@"文化",@"财经",@"房产",@"军事",nil];
//    }
//
//    return _titlesArr;
//}

- (IBAction)BACK:(id)sender {
    vc=self.childViewControllers[selectindex];
    if (vc.WebView.canGoBack) {
        [vc.WebView goBack];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if (_channelarr.count>0) {
        [array removeAllObjects];
        [self.titlesArr removeAllObjects];
        [_buttons removeAllObjects];
        if (idarray.count) {
            [idarray removeAllObjects];
        }

        for (int i=0; i<_channelarr.count; i++) {
            XLChannelModel *Model = _channelarr[i];
            NSString *string=Model.title;
            [self.titlesArr addObject:string];
            [idarray addObject:[iddic valueForKey:Model.title]];
        }

        for (UIViewController *vc in self.childViewControllers) {
            [vc willMoveToParentViewController:nil];
            [vc removeFromParentViewController];
        }
        
        [self.titleScrollView removeFromSuperview];
        [self.contentScrollView removeFromSuperview];
        //[self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self addChildViewController];    /** 添加子控制器视图  */
        
        [self setTitleScrollView];        /** 添加文字标签  */
        
        [self setContentScrollView];      /** 添加scrollView  */
        
        [self setupTitle];                /** 设置标签按钮 文字 背景图  */
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        self.contentScrollView.contentSize = CGSizeMake(self.titlesArr.count * kScreenW, 0);
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.showsHorizontalScrollIndicator  = NO;
        self.contentScrollView.delegate = self;
        
        //NSInteger i  = self.contentScrollView.contentOffset.x / ScreenW;
        [self selectTitleBtn:self.buttons[selectindex]];
        [self setUpOneChildController:selectindex];

        
        
        [_channelarr removeAllObjects];
        
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    array=[NSMutableArray array];
    idarray=[NSMutableArray array];
    idarr=[NSMutableArray array];
    self.titlesArr=[NSMutableArray array];
    _channelarr=[NSMutableArray array];
    
    iddic = @{@"推荐":@"1022",@"本地":@"1080",@"视频":@"1057",@"体育":@"1002",@"娱乐":@"1001",@"美女":@"1024",@"时尚":@"1009",@"母婴":@"1042",@"健康":@"1043",@"女人":@"1034",@"文化":@"1036",@"财经":@"1006",@"房产":@"1008",@"军事":@"1012",@"手机":@"1005",@"搞笑":@"1025",@"游戏":@"1040",@"动漫":@"1055"};

    idarr = [[NSMutableArray alloc] initWithObjects:@"1022",@"1080",@"1057",@"1002",@"1001",@"1024",@"1009",@"1042",@"1043",@"1034",@"1036",@"1006",@"1008",@"1012",@"1005",@"1025",@"1040",@"1055", nil];

    
    self.titlesArr = [[NSMutableArray alloc] initWithObjects:@"推荐",@"本地",@"视频",@"体育",@"娱乐",@"美女",@"时尚",@"母婴",@"健康",@"女人",@"文化",@"财经",@"房产",@"军事", nil];

    [self buildData];
    
    
    [self addChildViewController];    /** 添加子控制器视图  */
    
    [self setTitleScrollView];        /** 添加文字标签  */
    
    [self setContentScrollView];      /** 添加scrollView  */
    
    [self setupTitle];                /** 设置标签按钮 文字 背景图  */
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentScrollView.contentSize = CGSizeMake(self.titlesArr.count * kScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;

}
////初始化数据
-(void)buildData{
    if ([XLChannelControl shareControl].inUseItems.count) {return;}
    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"推荐",@"本地",@"视频",@"体育",@"娱乐",@"美女",@"时尚",@"母婴",@"健康",@"女人",@"文化",@"财经",@"房产",@"军事", nil];
    NSMutableArray *itemArr1 = [NSMutableArray new];
    for (NSString *str in arr1) {
        XLChannelModel *item = [XLChannelModel new];
        item.title = str;
        [itemArr1 addObject:item];
    }

    NSMutableArray *arr2 = [[NSMutableArray alloc] initWithObjects:@"手机",@"搞笑",@"游戏",@"动漫", nil];
    NSMutableArray *itemArr2 = [NSMutableArray new];
    for (NSString *str in arr2) {
        XLChannelModel *item = [XLChannelModel new];
        item.title = str;
        [itemArr2 addObject:item];
    }
    [XLChannelControl shareControl].inUseItems = itemArr1;
    [XLChannelControl shareControl].unUseItems = itemArr2;
}
-(void)more{
    [[XLChannelControl shareControl] showInViewController:self completion:^(NSMutableArray *channels) {
        //NSLog(@"频道管理结束：%@",channels);
        self.channelarr=channels;
    }];
}
#pragma mark - PRIVATE
-(void)addChildViewController{
    for (int i = 0; i<self.titlesArr.count; i++) {
        vc  = [[webViewController alloc] init];
        vc.title  =  self.titlesArr[i];
        vc.urlstr = [[BaiduMobCpuInfoManager shared] getCpuInfoUrlWithChannelId:[iddic valueForKey:self.titlesArr[i]] appId:@"cb3dcd92"];
        [self addChildViewController:vc];
    }
}
-(void)setTitleScrollView{
    CGRect rect  = CGRectMake(0, isheight, kScreenW-30, titleH);
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:self.titleScrollView];
    
    button=[YX_myUI createButtonWithFrame:CGRectMake(kScreenW-30, isheight+7, 30, 30) Target:self Selector:@selector(more) Image:@"more" ImagePressed:@"more"];
    [self.view addSubview:button];
}
-(void)setContentScrollView{
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y, ScreenW, ScreenH - titleH);
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.view addSubview:self.contentScrollView];
}

-(void)setupTitle{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat x = 0;
    CGFloat w = 60;
    CGFloat h = titleH;
    self.imageBackView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60-10, titleH-10)];
    self.imageBackView.image = [UIImage imageNamed:@"b1"];
    self.imageBackView.backgroundColor = [UIColor whiteColor];
    self.imageBackView.userInteractionEnabled = YES;
    [self.titleScrollView addSubview:self.imageBackView];
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0)
        {
            [self click:btn];
        }
        
    }
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
}
-(void)click:(UIButton *)sender{
    [self selectTitleBtn:sender];
    selectindex = sender.tag;
    CGFloat x  = selectindex *ScreenW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self setUpOneChildController:selectindex];
}
-(void)selectTitleBtn:(UIButton *)btn{
    
    [self.selectedBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    self.selectedBtn = btn;
    
    [self setupTitleCenter:btn];
}

-(void)setupTitleCenter:(UIButton *)sender
{
    
    CGFloat offset = sender.center.x - ScreenW * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - ScreenW;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

-(void)setUpOneChildController:(NSInteger)index{
    CGFloat x  = index * ScreenW;
    UIViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, ScreenW, ScreenH - self.contentScrollView.frame.origin.y);
    [self.contentScrollView addSubview:vc.view];
    
}
#pragma mark - UIScrollView  delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    selectindex  = self.contentScrollView.contentOffset.x / ScreenW;
    [self selectTitleBtn:self.buttons[selectindex]];
    [self setUpOneChildController:selectindex];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX  = scrollView.contentOffset.x;
    NSInteger leftIndex  = offsetX / ScreenW;
    NSInteger rightIdex  = leftIndex + 1;
    
    UIButton *leftButton = self.buttons[leftIndex];
    UIButton *rightButton  = nil;
    if (rightIdex < self.buttons.count) {
        rightButton  = self.buttons[rightIdex];
    }
    CGFloat scaleR  = offsetX / ScreenW - leftIndex;
    CGFloat scaleL  = 1 - scaleR;
    CGFloat transScale = MaxScale - 1;
    
    self.imageBackView.transform  = CGAffineTransformMakeTranslation((offsetX*(self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    //UIColor *rightColor = [UIColor colorWithRed:(174+66*scaleR)/255.0 green:(174-71*scaleR)/255.0 blue:(174-174*scaleR)/255.0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:(174+66*scaleL)/255.0 green:(174-71*scaleL)/255.0 blue:(174-174*scaleL)/255.0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    
}

@end
