//
//  fxdetailVController.m
//  TianZeLan
//
//  Created by apple on 2018/6/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "fxdetailVController.h"
#import "header.h"

static NSString *cellId = @"detailTableViewCell";

@interface fxdetailVController ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UIView *_picView;
    UILabel *_timela;
    UIView *_botview;
    NSInteger HHeight;
    NSInteger kheight;
    NSInteger kwidth;
    UITableView * tableView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *Scrollview;
@end

@implementation fxdetailVController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self SETUP];
}

-(void)SETUP{
    _iconView = [UIImageView new];
    _iconView.image=[UIImage imageNamed:_model.iconName];
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    _nameLable.text=_model.name;

    _timela = [UILabel new];
    _timela.text=[NSString stringWithFormat:@"2018-%d-%d",arc4random_uniform(12),arc4random_uniform(30)];
    _timela.font = [UIFont systemFontOfSize:12];

    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:18];
    _contentLabel.numberOfLines = 0;
    _contentLabel.text=_model.msgContent;

    _picView =[UIView new];
   
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight,kScreenW,kScreenH-51-isheight) style:UITableViewStylePlain];
    UINib *nib = [UINib nibWithNibName:@"detailTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellId];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorColor=[UIColor clearColor];
    //tableView.backgroundColor=RGBA(242, 242, 242, 1);

    NSArray *views = @[_iconView,_nameLable,_timela,_contentLabel,_picView,tableView];

    [_Scrollview sd_addSubviews:views];

    CGFloat margin = 10;

    _iconView.sd_layout
    .leftSpaceToView(_Scrollview, 20)
    .topSpaceToView(_Scrollview, margin + 5)
    .widthIs(40)
    .heightIs(40);

    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];

    _timela.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, margin)
    .heightIs(15)
    .widthIs(100);

    _contentLabel.sd_layout
    .leftEqualToView(_iconView)
    .topSpaceToView(_iconView, margin)
    .rightSpaceToView(_Scrollview, 20)
    .autoHeightRatio(0);

    for (int i=0; i<_model.picNamesArray.count; i++) {
        CGSize size = [UIImage imageNamed:_model.picNamesArray[i]].size;
        if (size.width>kScreenW-40) {
            kwidth = kScreenW-40;
        }else{
            kwidth = size.width;
        }
        UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(0,HHeight+10*i,kwidth,size.height)];
        imgview.image=[UIImage imageNamed:_model.picNamesArray[i]];
        imgview.contentMode=UIViewContentModeScaleAspectFill;
        imgview.clipsToBounds=YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [imgview addGestureRecognizer:tapGestureRecognizer];
        imgview.userInteractionEnabled=YES;
        [_picView addSubview:imgview];
        HHeight+=size.height;
    }
    
    _picView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, margin)
    .rightSpaceToView(_Scrollview, 20)
    .heightIs(HHeight+10*_model.picNamesArray.count);//*****
 
    
    tableView.sd_layout
    .leftEqualToView(_Scrollview)
    .rightEqualToView(_Scrollview)
    .topSpaceToView(_picView, margin)
    .heightIs(424);

    [_Scrollview setupAutoHeightWithBottomView:tableView bottomMargin:15];
}
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array1=@[@"今天好气啊",@"春风西来",@"两只黄鹂鸣翠柳"];
    NSArray *array2=@[@"在人人都有麦克风的时代,有几人保持清流",@"鞋子很好看,请问还有别的款式吗",@"两只黄鹂鸣翠柳,我还没有女朋友"];
    detailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[detailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    cell.backgroundColor=[UIColor whiteColor];
    cell.namelabel.text=array1[indexPath.row];
    cell.contentlabel.text=array2[indexPath.row];
    cell.iconimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"%u",arc4random_uniform(23)]];
    cell.sideimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"icon%u",arc4random_uniform(7)]];
    cell.timalabel.text=[NSString stringWithFormat:@"2018-%u-%u",arc4random_uniform(12),arc4random_uniform(29)];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *Headview=[[UIView alloc]init];
    [Headview addSubview:[YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 1) Backgroundcolor:RGBA(222, 222, 222, 1)]];
    [Headview addSubview:[YX_myUI createLabelWithFrame:CGRectMake(10, 4, 80, 30) Text:@"评论" TextAlignment:NSTextAlignmentCenter]];
    [Headview addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-120, 4, 100, 30) Font:13 Text:@"共3条评论 >" textcolor:[UIColor lightGrayColor] TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
    return Headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
@end
