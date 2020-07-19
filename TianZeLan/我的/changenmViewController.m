//
//  changenmViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "changenmViewController.h"
#import "header.h"
@interface changenmViewController ()
{
    MBProgressHUD *hud;
}

@property (weak, nonatomic) IBOutlet UITextField *Textfield;
@property (weak, nonatomic) IBOutlet UIButton *Savebtn;

@end

@implementation changenmViewController

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"保存"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [_Savebtn setAttributedTitle:title
                        forState:UIControlStateNormal];
}
/**
 @param sender 修改名字
 */
- (IBAction)SureChange:(id)sender {
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:_Textfield.text];
    
    if (!isMatch){
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"昵称只能由中文、字母或数字组成";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"修改成功";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
