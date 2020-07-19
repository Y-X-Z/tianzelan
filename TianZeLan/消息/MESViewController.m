//
//  MESViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MESViewController.h"
#import "header.h"


static NSString *cellId = @"MesTableViewCell";

@interface MESViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * picImageNamesArray1;
    NSArray * NamesArray1;
    UITableView * tableView;
    
}
@end

@implementation MESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    picImageNamesArray1 = @[@"xpinglun",@"xzan",@"xtongzhi"];

    NamesArray1 = @[@"评论",@"点赞",@"系统通知"];
    
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight,kScreenW,kScreenH-51-isheight) style:UITableViewStylePlain];
    UINib *nib = [UINib nibWithNibName:@"MesTableViewCell" bundle:nil];
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
    return picImageNamesArray1.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    mmViewController *mvc = [mmViewController new];
    mvc.hidesBottomBarWhenPushed = YES;
    mvc.titlela=NamesArray1[indexPath.row];
    [self.navigationController pushViewController:mvc animated:YES];
}
/**
 errorTableViewCell 赋值
 @param tableView 表格
 @param indexPath 行数
 @return cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[MesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    cell.backgroundColor=[UIColor whiteColor]; 
    cell.imagev.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",picImageNamesArray1[indexPath.row]]];
    cell.content.text=[NSString stringWithFormat:@"%@",NamesArray1[indexPath.row]];
    return cell;
   
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
