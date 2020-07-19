//
//  shouyiViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "shouyiViewController.h"
#import "header.h"


@interface shouyiViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation shouyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
