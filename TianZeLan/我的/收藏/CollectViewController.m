//
//  CollectViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CollectViewController.h"
#import "header.h"


static NSString  *cellIdentifier=@"CollTableViewCell";
static NSString *tocellIdentifier = @"todayCell";

@interface CollectViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    __weak IBOutlet UIButton *editbtn;
    NSMutableArray *Array;
    NSMutableArray *labelarray;
    NSMutableArray *dataarr;
    NSMutableArray *dtArray;
    NSMutableArray *searchArray;
    NSMutableArray *courseArray;
    UITableView *_tableView;
    int pageSize;
    NSDictionary *paramete;
    NSString *token;
    NSString *collectType;
    NSMutableArray *imagearr;
    UICollectionView *NormalCollection;
    UIButton *delbtn;
    todayCell *cell;
    NSArray *arr;
    NSArray *titlearr;

}
@property(strong,nonatomic)UIScrollView *myScrollView;
//滚动下划线
@property(strong,nonatomic)UIView *line;
//所有的Button集合
@property(nonatomic,strong)NSMutableArray  *items;
//所有的Button的宽度集合
@property(nonatomic,copy)NSArray *itemsWidth;
//被选中前面的宽度合（用于计算是否进行超过一屏，没有一屏则进行平分）
@property(nonatomic,assign)CGFloat selectedTitlesWidth;

@end

@implementation CollectViewController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makescor];
    [self inittabview];

    
    
    arr=[NSArray array];
    titlearr=[NSArray array];
    dataarr=[NSMutableArray array];
    dtArray=[NSMutableArray array];
    searchArray=[NSMutableArray array];
    courseArray=[NSMutableArray array];
    Array=[NSMutableArray array];
    labelarray=[NSMutableArray array];
    imagearr=[NSMutableArray array];
    
    
    
    
    arr = [NSArray arrayWithObjects:
           @"https://img.alicdn.com/imgextra/i2/1791648946/TB1R1Zhd7OWBuNjSsppXXXPgpXa_!!0-item_pic.jpg_430x430q90.jpg",
           @"https://gaitaobao1.alicdn.com/tfscom/i4/2933336379/TB2mXHCuH5YBuNjSspoXXbeNFXa_!!2933336379-0-item_pic.jpg_300x300q90.jpg",
           @"https://gaitaobao4.alicdn.com/tfscom/i4/TB1v.TrQVXXXXabaFXXXXXXXXXX_!!0-item_pic.jpg_300x300q90.jpg",
           @"https://gaitaobao4.alicdn.com/tfscom/i3/2879319564/TB2NLrZbHuWBuNjSszgXXb8jVXa_!!2879319564.jpg_300x300q90.jpg",
           @"https://gaitaobao1.alicdn.com/tfscom/i4/1579510920/TB2WidCrwmTBuNjy1XbXXaMrVXa_!!1579510920-0-item_pic.jpg_300x300q90.jpg",
           @"https://gaitaobao3.alicdn.com/tfscom/i4/678348281/TB2rJbytohnpuFjSZFpXXcpuXXa_!!678348281.jpg_300x300q90.jpg", nil];
    
    titlearr = [NSArray arrayWithObjects:
                @"润盈敏+500亿活性益生菌粉儿童成人冻干粉固体饮料含益生元36条",
                @"空调挡风板坐月子导风板出风口冷气防直吹挡板风向伸缩通用遮风板",
                @"诺必行婴宝护肤霜13.5g 婴儿湿痒红屁屁护臀膏无激素特护膏",
                @"瘦脸神器V脸瘦脸仪脸部滚轮按摩器瘦咬肌面部美容仪双下巴美容棒",
                @"义鼎森时尚百搭潮流纯色竹节棉打底青年男圆领套头短袖T恤男透气",
                @"买2发7】汤臣倍健健力多R氨糖软骨素钙片 1.02g/片*40片*3瓶套餐",nil];
    
}
-(void)inittabview{
    
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight+36, kScreenW, kScreenH-isheight-36) style:UITableViewStylePlain];
    UINib *nib = [UINib nibWithNibName:@"CollTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tag=100;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    [_tableView addSubview:[YX_myUI createImageViewFrame:CGRectMake(kScreenW/2-60, 150, 120, 160) imageName:@"CHAHUA"]];
    
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc] init];
    NormalCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0,isheight+36,kScreenW,kScreenH-isheight-36)collectionViewLayout:flow];
    NormalCollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UINib *cellNib=[UINib nibWithNibName:@"todayCell" bundle:nil];
    flow.sectionInset =UIEdgeInsetsMake(0,10, 0, 10);
    [NormalCollection registerNib:cellNib forCellWithReuseIdentifier:tocellIdentifier];
    NormalCollection.allowsMultipleSelection=YES;
    NormalCollection.delegate = self;
    NormalCollection.dataSource = self;
    [self.view addSubview:NormalCollection];
    
    self->NormalCollection.hidden = YES;
    self->_tableView.hidden = NO;
    
    delbtn = [YX_myUI createButtonWithFrame:CGRectMake(0, kScreenH-44, kScreenW, 44) Title:@"删除" Target:self Selector:@selector(deletecell)];
    delbtn.backgroundColor=[UIColor redColor];

    [self.view addSubview:delbtn];
    delbtn.hidden=YES;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW-20)/2,(kScreenW-20)*26/34);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,5,0,5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
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
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:tocellIdentifier forIndexPath:indexPath];
    [cell.headimagev sd_setImageWithURL:[NSURL URLWithString:arr[indexPath.item]] placeholderImage:[UIImage imageNamed:@"no_image.9"]];
    float domstr=50 +  (arc4random() % 101);
    float youhuistr=10 +  (arc4random() % 50);
    float Quanhoujia = (arc4random() % 50);
    cell.nowpricelabel.text=[NSString stringWithFormat:@"现价￥%.f",domstr];
    cell.youhuiquan.text = [NSString stringWithFormat:@"%.2f元优惠券",youhuistr];
    cell.xiaoliang.text = [NSString stringWithFormat:@"已售%u",(arc4random() % 50) +500];
    cell.quanhoujia.text = [NSString stringWithFormat:@"券后价:￥%.2f",Quanhoujia];
    cell.titlelabel.text = [NSString stringWithFormat:@"%@",titlearr[indexPath.item]];
    return cell;
}
/**
 didSelectItemAtIndexPath 点击跳转
 @param collectionView collectionView
 @param indexPath 行数
 */

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    cell = (todayCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectbtn.hidden = NO;
    [cell.selectbtn setBackgroundImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
    
}
/**
 点击LoveCollectionViewCell
 @param collectionView _yxcollection _Array移除数组 cell取消对号
 @param indexPath 接口的数据源的个数item
 */
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    cell = (todayCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectbtn.hidden = YES;
    [cell.selectbtn setBackgroundImage:[UIImage imageNamed:@"sig"] forState:UIControlStateNormal];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[CollTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    if (indexPath.row<5) {
        cell.headimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld",(long)indexPath.row]];
    }if (indexPath.row>=5) {
        cell.headimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld",(long)indexPath.row-5]];
    }
    return cell;
}
-(void)makescor{
    self.automaticallyAdjustsScrollViewInsets=NO;
    //初始化数组
    if (!self.myTitleArray) {
        self.myTitleArray=@[@"文章",@"商品"];
    }
    self.items=[[NSMutableArray alloc]init];
    self.itemsWidth=[[NSArray alloc]init];
    //初始化滚动
    if (!self.myScrollView) {
        self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,isheight, kScreenW, NAV_TAB_BAR_HEIGHT)];
        self.myScrollView.backgroundColor=[UIColor whiteColor];
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.myScrollView];
    }
    //赋值跟计算滚动
    _itemsWidth = [self getButtonsWidthWithTitles:self.myTitleArray];
    CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
    self.myScrollView.contentSize = CGSizeMake(contentWidth, 0);
    self.currentIndex=0;
}
#pragma scroll
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles{
    NSMutableArray *widths = [@[] mutableCopy];
    _selectedTitlesWidth = 0;
    for (NSString *title in titles)
    {
        CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : TABBAR_TITLE_FONT} context:nil].size;
        CGFloat eachButtonWidth = size.width + 20.f;
        _selectedTitlesWidth += eachButtonWidth;
        NSNumber *width = [NSNumber numberWithFloat:eachButtonWidth];
        [widths addObject:width];
    }
    if (_selectedTitlesWidth < kScreenW) {
        [widths removeAllObjects];
        NSNumber *width = [NSNumber numberWithFloat:kScreenW / titles.count];
        for (int index = 0; index < titles.count; index++) {
            [widths addObject:width];
        }
    }
    return widths;
}
- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = 0;
    for (NSInteger index = 0; index < widths.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, 0, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
        button.titleLabel.font = TABBAR_TITLE_FONT;
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:self.myTitleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myScrollView addSubview:button];
        [_items addObject:button];
        buttonX += [widths[index] floatValue];
    }
    if (widths.count) {
        [self showLineWithButtonWidth:[widths[0] floatValue]];
    }
    return buttonX;
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    UIButton *button = nil;
    button = _items[currentIndex];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    CGFloat offsetX = button.center.x - kScreenW * 0.5;
    CGFloat offsetMax = _selectedTitlesWidth - kScreenW;
    if (offsetX < 0 || offsetMax < 0) {
        offsetX = 0;
    } else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    [self.myScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [UIView animateWithDuration:.2f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + _selectedTitlesWidth/2, _line.frame.origin.y, [_itemsWidth[currentIndex] floatValue] - _selectedTitlesWidth, _line.frame.size.height);
    }];
}
- (void)showLineWithButtonWidth:(CGFloat)width{
    _line = [[UIView alloc] initWithFrame:CGRectMake(50.0f, NAV_TAB_BAR_HEIGHT - 3.0f, width - 100.0f, 1.0f)];
    _line.backgroundColor = [UIColor redColor];
    [self.myScrollView addSubview:_line];
}
- (void)cleanData
{
    [_items removeAllObjects];
    [self.myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    self.currentIndex=index;
    
//    if ([self.delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
//        [self.delegate itemDidSelectedWithIndex:index];
//    }
    //修改选中跟没选中的Button字体颜色
    for (int i=0; i<_items.count; i++) {
        if (i==index) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
            [_items[i] setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            if (index==0) {
                self->NormalCollection.hidden = YES;
                self->_tableView.hidden = NO;
            }if (index==1) {
                self->NormalCollection.hidden = NO;
                self->_tableView.hidden = YES;
            }

            
        }];
    }];
}
-(void)deletecell{
   
    NSString *message = @"";

    NSString *title = @"确定要删除这些商品吗";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [titleAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    [alertController setValue:titleAtt forKey:@"attributedTitle"];
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, message.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, message.length)];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self SelectSURE];

        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    [alertController addAction:alertAction];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [cancel setValue:[UIColor darkGrayColor] forKey:@"_titleTextColor"];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)SelectSURE{
    
    cell.selectbtn.hidden=YES;
    [NormalCollection reloadData];
   
}
- (IBAction)editing:(id)sender {
    editbtn.selected=!editbtn.selected;
    if (_tableView.hidden) {
        delbtn.hidden=!delbtn.hidden;
        [NormalCollection reloadData];

    }else{
        _tableView.editing=!_tableView.editing;
    }
}
@end
