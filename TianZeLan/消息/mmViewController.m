//
//  mmViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "mmViewController.h"
#import "header.h"


static NSString *cellId = @"detailTableViewCell";

@interface mmViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * picImageNamesArray1;
    NSArray * NamesArray1;
    UITableView * tableView;
    
}
@property (weak, nonatomic) IBOutlet UILabel *headtitle;

@end

@implementation mmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headtitle.text=[NSString stringWithFormat:@"%@",_titlela];
    
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
    tableView.backgroundColor=RGBA(242, 242, 242, 1);
    [self.view addSubview:tableView];
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
//    mmViewController *mvc = [mmViewController new];
//    mvc.hidesBottomBarWhenPushed = YES;
//    mvc.titlela=NamesArray1[indexPath.row];
//    [self.navigationController pushViewController:mvc animated:YES];
}
/**
 errorTableViewCell 赋值
 @param tableView 表格
 @param indexPath 行数
 @return cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array1=@[@"今天好气啊",@"春风西来",@"两只黄鹂鸣翠柳",@"我是攻城狮",@"赤橙黄绿青蓝紫"];
    NSArray *array2=@[@"在人人都有麦克风的时代,有几人保持清流",@"鞋子很好看,请问还有别的款式吗",@"两只黄鹂鸣翠柳,我还没有女朋友",@"美记:勒布朗已经做出决定 决定3将于星期二公布",@"窒息!世界杯史上最 失败 点球大战 两门将神仙打架"];
    detailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[detailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    cell.backgroundColor=[UIColor whiteColor];
    cell.namelabel.text=array1[arc4random_uniform(5)];
    cell.contentlabel.text=array2[arc4random_uniform(5)];
    cell.iconimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"%u",arc4random_uniform(23)]];
    cell.sideimagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"icon%u",arc4random_uniform(7)]];
    cell.timalabel.text=[NSString stringWithFormat:@"2018-%u-%u",arc4random_uniform(12),arc4random_uniform(29)];
    return cell;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
