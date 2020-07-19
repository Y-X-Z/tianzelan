//
//  settingViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "settingViewController.h"

#import "header.h"
#import "SDImageCache.h"

static NSString *cellId = @"detailTableViewCell";


@interface settingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * picImageNamesArray1;
    NSArray * NamesArray1;
    UITableView * tableView;
    NSArray *array;
    double displaySize;
    MBProgressHUD *hud;
}

@end

@implementation settingViewController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    displaySize = [SZKCleanCache folderSizeAtPath];
    
    array = @[@"清除缓存", @"隐私之策",@"关于海豚社区",@"当前版本"];
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,isheight,kScreenW,kScreenH-isheight) style:UITableViewStylePlain];
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
    if (indexPath.row==0) {
        if (self->displaySize>0) {
            [SZKCleanCache cleanCache:^{
                self->displaySize = [SZKCleanCache folderSizeAtPath];
                [tableView reloadData];
                self->hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                self->hud.mode = MBProgressHUDModeText;
                self->hud.label.text = @"清除成功";
                self->hud.offset = CGPointMake(0.f, 0.f);
                [self->hud hideAnimated:YES afterDelay:2.f];
            }];
        }else{
            hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"暂无缓存可以清除";
            hud.offset = CGPointMake(0.f, 0.f);
            [hud hideAnimated:YES afterDelay:2.f];
            
        }
    }
    if (indexPath.row==2) {
        [self.navigationController pushViewController:[AboutweVController new] animated:YES];
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
    cell.textLabel.text=[NSString stringWithFormat:@"%@",array[indexPath.row]];
    if (indexPath.row==0) {
        [cell.contentView addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-100, 5, 90, 40) Font:13 Text:[NSString stringWithFormat:@"%.2fM",displaySize] textcolor:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter numberOfLines:1]];

    }
    if (indexPath.row==3) {
        [cell.contentView addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW-100, 5, 90, 40) Font:13 Text:@"V1.0" textcolor:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
    }
    return cell;
}





@end
