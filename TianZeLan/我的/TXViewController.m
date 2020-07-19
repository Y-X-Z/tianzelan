//
//  TXViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "TXViewController.h"
#import "header.h"

@interface TXViewController ()<UITextFieldDelegate>
{
    MBProgressHUD*hud;
    
}
@property (weak, nonatomic) IBOutlet UITextField *Moneyfield;
@property (weak, nonatomic) IBOutlet UITextField *Numfield;
@property (weak, nonatomic) IBOutlet UIButton *Txbtn;

@end

@implementation TXViewController

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Moneyfield.delegate = self;
    _Numfield.delegate = self;
    _Txbtn.enabled=NO;
}
- (IBAction)tixain:(id)sender {
    if ([_Moneyfield.text isEqualToString:@""]) {
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"提现金额不能为空";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    } if ([_Numfield.text isEqualToString:@""]) {
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"收款账户不能为空";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        if ([_Moneyfield.text integerValue]<10) {
            hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"提现金额必须大于10元才可以提现";
            hud.offset = CGPointMake(0.f, 0.f);
            [hud hideAnimated:YES afterDelay:2.f];
        }else{
            hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"提现成功,请查看到账明细";
            hud.offset = CGPointMake(0.f, 0.f);
            [hud hideAnimated:YES afterDelay:2.f];
            [self.navigationController popViewControllerAnimated:YES];
        }     
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([_Moneyfield.text isEqualToString:@""]||[_Numfield.text isEqualToString:@""]) {
        _Txbtn.enabled=NO;
    }else{
        _Txbtn.enabled=YES;
    }
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
