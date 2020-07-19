//
//  PsoninfoViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PsoninfoViewController.h"
#import "header.h"

static NSString *cellId = @"detailTableViewCell";
@interface PsoninfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * picImageNamesArray1;
    NSArray * NamesArray1;
    UITableView * tableView;
    NSArray *array;
}
@end

@implementation PsoninfoViewController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    array = @[@"我的头像", @"我的昵称",@"绑定淘宝订单号",@"退出登录"];
    
    
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight,kScreenW,kScreenH-isheight) style:UITableViewStylePlain];
    //UINib *nib = [UINib nibWithNibName:@"detailTableViewCell" bundle:nil];
    //[tableView registerNib:nib forCellReuseIdentifier:cellId];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    
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
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        changenmViewController *ChangeNmeC=[changenmViewController new];
        ChangeNmeC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:ChangeNmeC animated:YES];
    }
    if (indexPath.row==3) {
        NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [defatluts dictionaryRepresentation];
        for(NSString *key in [dictionary allKeys]){
            [defatluts removeObjectForKey:key];
            [defatluts synchronize];
        }
        [self.navigationController popViewControllerAnimated:YES];

        logViewController *loginview = [logViewController sharedManager];
        UINavigationController *nvc=[[UINavigationController alloc]initWithRootViewController:loginview];
        nvc.navigationBar.hidden=YES;
        [UIApplication sharedApplication].keyWindow.rootViewController=nvc;
    }
}
/**
 errorTableViewCell 赋值
 @param tableView 表格
 @param indexPath 行数
 @return cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    cell.backgroundColor=[UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    cell.textLabel.text=[NSString stringWithFormat:@"%@",array[indexPath.row]];
    if (indexPath.row==0) {
        [cell.contentView addSubview:[YX_myUI createImageViewFrame:CGRectMake(kScreenW-80, 5, 40, 40) imageName:@"icon4"]];
    }
    if (indexPath.row==1) {
        [cell.contentView addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-120, 5, 100, 40) Font:13 Text:@"151****1004" textcolor:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
    }
    return cell;
}



@end
