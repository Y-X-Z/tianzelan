//
//  myallowerViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "myallowerViewController.h"
#import "header.h"
#import "allowhead.h"

static NSString  *cellIdentifier=@"allowTableViewCell";

@interface myallowerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    Erweimaview *ewmview;
    UIImageView *imageview;
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

@implementation myallowerViewController
- (IBAction)bcak:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makescor];
    [self inittabview];
}
-(void)inittabview{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight+36, kScreenW, kScreenH-isheight-36) style:UITableViewStylePlain];
    UINib *nib = [UINib nibWithNibName:@"allowTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.backgroundColor=RGBA(242, 242, 242, 1);
    [self.view addSubview:_tableView];
    
    imageview=[[UIImageView alloc]init];
    imageview.frame= CGRectMake(kScreenW/2-110, isheight+60, 220, 220);
    imageview.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:@"http://www.tianzelan.com" logoImageName:@"head1" logoScaleToSuperView:0.2];
    [self.view addSubview:imageview];
    _tableView.hidden=NO;
    imageview.hidden=YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    allowTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[allowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.headimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld",(long)indexPath.row]];
    float domstr=100 +  (arc4random() % 101);
    cell.numberper.text=[NSString stringWithFormat:@"1%ld",(long)indexPath.row];
    cell.input.text=[NSString stringWithFormat:@"%.2f",domstr];
    cell.content.text=[NSString stringWithFormat:@"123%ld42131",indexPath.row+5];
    cell.timelabel.text=[NSString stringWithFormat:@"注册日期2018050%ld",(long)indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    allowhead *Headview=[[allowhead alloc]init];
    return Headview;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *LABEL=[YX_myUI createLabelWithFrame:CGRectMake(0, 10, kScreenW, 30) Font:13 Text:@"已经到底了" textcolor:RGBA(102, 102, 102, 1) TextAlignment:NSTextAlignmentCenter numberOfLines:1];
    return  LABEL;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(void)makescor{
    self.automaticallyAdjustsScrollViewInsets=NO;
    //初始化数组
    if (!self.myTitleArray) {
        self.myTitleArray=@[@"我邀请的人",@"邀请我的人"];
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
        _line.frame = CGRectMake(button.frame.origin.x + 40, _line.frame.origin.y, [_itemsWidth[currentIndex] floatValue] - 80, _line.frame.size.height);
    }];
}
- (void)showLineWithButtonWidth:(CGFloat)width{
    _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 3.0f, width - 4.0f, 1.0f)];
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
                self->imageview.hidden = YES;
                self->_tableView.hidden = NO;
            }if (index==1) {
                self->imageview.hidden = NO;
                self->_tableView.hidden = YES;
            }
            
            
            
            

        }];
    }];
}

@end
