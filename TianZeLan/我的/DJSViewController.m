//
//  DJSViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DJSViewController.h"
#import "header.h"
#define NAV_TAB_BAR_HEIGHT 36
#define NAV_TAB_BAR_Width  SCREEN_WIDTH

static NSString *cellId = @"djsTableViewCell";

@interface DJSViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *array;
    NSArray * picImageNamesArray1;
    NSArray * NamesArray1;
    UITableView * tableView;
    NSString * PKID;
    djsfootview *Footview;
    UILabel *Headlabel;
    UIView *headview;
}
@property (weak, nonatomic) IBOutlet UILabel *headtitle;
@property(strong,nonatomic)UIScrollView *myScrollView;
//滚动下划线
@property(strong,nonatomic)UIView *line;
@property(nonatomic,strong)NSArray *channelarr;
//所有的Button集合
@property(nonatomic,strong)NSMutableArray  *items;
//所有的Button的宽度集合
@property(nonatomic,copy)NSArray *itemsWidth;
//被选中前面的宽度合（用于计算是否进行超过一屏，没有一屏则进行平分）
@property(nonatomic,assign)CGFloat selectedTitlesWidth;

@end

@implementation DJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelarr=[NSArray array];
    array=[NSMutableArray array];
    [self inittabview];
    [self makescor];
    
    
    _headtitle.text=_headstr;

}
-(void)inittabview{
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight+NAV_TAB_BAR_HEIGHT,kScreenW,kScreenH-36-isheight) style:UITableViewStyleGrouped];
    UINib *nib = [UINib nibWithNibName:@"djsTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellId];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorColor=[UIColor groupTableViewBackgroundColor];
    tableView.backgroundColor=RGBA(242, 242, 242, 1);
    [self.view addSubview:tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            headview=[[UIView alloc]init];
            headview.backgroundColor=[UIColor whiteColor];
            [headview addSubview: [YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 10) Backgroundcolor:RGBA(242, 242, 242, 1)]];
            [headview addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-100, 15, 80, 30) Font:15 Text:@"已付款" textcolor:RGBA(102, 102, 102, 1) TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
            
            return headview;
            break;
        case 1:
            headview=[[UIView alloc]init];
            headview.backgroundColor=[UIColor whiteColor];
            [headview addSubview: [YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 10) Backgroundcolor:RGBA(242, 242, 242, 1)]];
            [headview addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-100, 15, 80, 30) Font:15 Text:@"确认收货" textcolor:RGBA(102, 102, 102, 1) TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
            return headview;
            break;
        case 2:
            headview=[[UIView alloc]init];
            headview.backgroundColor=[UIColor whiteColor];
            [headview addSubview: [YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 10) Backgroundcolor:RGBA(242, 242, 242, 1)]];
            [headview addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-100, 15, 80, 30) Font:15 Text:@"已取消" textcolor:RGBA(102, 102, 102, 1) TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
            return headview;
            break;
        default:
            break;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            Footview=[[djsfootview alloc]init];
            return Footview;
            break;
        case 1:
            Footview=[[djsfootview alloc]init];
            Footview.button1.hidden=YES;
            [Footview.button2 setBackgroundImage:[UIImage imageNamed:@"sharesp"] forState:UIControlStateNormal];
            [Footview.button3 setBackgroundImage:[UIImage imageNamed:@"wuliu"] forState:UIControlStateNormal];
            return Footview;
            break;
        case 2:
            Footview=[[djsfootview alloc]init];
            Footview.button1.hidden=YES;
            Footview.button2.hidden=YES;
            [Footview.button3 setBackgroundImage:[UIImage imageNamed:@"sharesp"] forState:UIControlStateNormal];
            return Footview;
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
/**
 errorTableViewCell 赋值
 @param tableView 表格
 @param indexPath 行数
 @return cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    djsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[djsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    cell.backgroundColor=[UIColor whiteColor];
    cell.imagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"%u",arc4random_uniform(23)]];
    return cell;
}
-(void)makescor{
    self.automaticallyAdjustsScrollViewInsets=NO;
    //初始化数组
    if (!self.myTitleArray) {
        self.myTitleArray=@[@"全部",@"已付款",@"确认收货",@"已取消"];
    }
    self.items=[NSMutableArray array];
    self.itemsWidth=[[NSArray alloc]init];
    //初始化滚动
    if (!self.myScrollView) {
        self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,isheight, kScreenW, NAV_TAB_BAR_HEIGHT)];
        self.myScrollView.backgroundColor=RGBA(255, 255, 255, 1);
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.myScrollView];
    }
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
    if (_selectedTitlesWidth < NAV_TAB_BAR_Width) {
        [widths removeAllObjects];
        NSNumber *width = [NSNumber numberWithFloat:NAV_TAB_BAR_Width / titles.count];
        for (int index = 0; index < titles.count; index++) {
            [widths addObject:width];
        }
    }
    return widths;
}
- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = 0;
    if (self.channelarr.count>0) {
        [_items removeAllObjects];
    }
    for (NSInteger index = 0; index < widths.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, 0, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
        button.titleLabel.font = TABBAR_TITLE_FONT;
        button.backgroundColor = [UIColor clearColor];
        if (self.channelarr.count>0) {
            [button setTitle:array[index] forState:UIControlStateNormal];
        }
        else{
            [button setTitle:self.myTitleArray[index] forState:UIControlStateNormal];
        }
        if (index == 0) {
            [button setTitleColor:RGBA(237, 43, 54, 1) forState:UIControlStateNormal];
        }else{
            [button setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        }
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
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    UIButton *button = nil;
    button = _items[currentIndex];
    if (_currentIndex == 0) {
        [button setTitleColor:RGBA(237, 43, 54, 1) forState:UIControlStateNormal];
    }else{
        [button setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    }
    CGFloat offsetX = button.center.x - NAV_TAB_BAR_Width * 0.5;
    CGFloat offsetMax = _selectedTitlesWidth - NAV_TAB_BAR_Width;
    if (offsetX < 0 || offsetMax < 0) {
        offsetX = 0;
    } else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    [self.myScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [UIView animateWithDuration:.2f animations:^{
        self->_line.frame = CGRectMake(button.frame.origin.x + 2.0f, self->_line.frame.origin.y, [self->_itemsWidth[currentIndex] floatValue] - 4.0f, self->_line.frame.size.height);
    }];
}
- (void)showLineWithButtonWidth:(CGFloat)width
{
    _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 3.0f, width - 4.0f, 3.0f)];
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
    
    if ([self.delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [self.delegate itemDidSelectedWithIndex:index];
    }
    
    //修改选中跟没选中的Button字体颜色
    for (int i=0; i<_items.count; i++) {
        if (i==index) {
            [button setTitleColor:RGBA(237, 43, 54, 1) forState:UIControlStateNormal];
        }
        else
        {
            [_items[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            
        }];
    }];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
