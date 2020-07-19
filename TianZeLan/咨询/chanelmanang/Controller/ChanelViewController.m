//
//  ChanelViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ChanelViewController.h"
#import "header.h"

@interface ChanelViewController ()
{
    VoidBlock _backBlock;
}
@property (nonatomic , strong)UIScrollView *ScrollView;
@property (nonatomic , strong)NSMutableArray *myChannelArr;
@property (nonatomic , strong)NSMutableArray *recommendChannelArr;
// iOS6 之后不用自己手动回收
@property (nonatomic , strong)dispatch_queue_t queue;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , assign)CGFloat labelWidth;

@property (nonatomic , assign)CGRect header1_frame;
@end

@implementation ChanelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    XLChannelView *menu = [[XLChannelView alloc] initWithFrame:CGRectMake(0, isheight, kScreenW, kScreenH - isheight)];
    [self.view addSubview:menu];
    
}

-(void)addBackBlock:(VoidBlock)block
{
    _backBlock = block;
}

- (IBAction)BACK:(id)sender {
    //回调返回block
    if (_backBlock) {
        _backBlock();
        [self.navigationController popViewControllerAnimated:YES];

    }
    //返回
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
