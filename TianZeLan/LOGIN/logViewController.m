//
//  logViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "logViewController.h"
#import "header.h"

@interface logViewController ()<UITextFieldDelegate>
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UITextField *AcountedField;
@property (weak, nonatomic) IBOutlet UITextField *yzmfield;
@property (weak, nonatomic) IBOutlet UIButton *Loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *RegisterBTN;
@property (weak, nonatomic) IBOutlet UIButton *YZMBTN;
@end

@implementation logViewController


/**
 LoginViewController
 频繁登录,登录单例
 @return sharedManager
 */
+ (logViewController *)sharedManager{
    static logViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

/**
 登录按钮
 @param sender Login
 */
-(IBAction)Login:(id)sender {
    YXtabbarViewController *tabbarc = [YXtabbarViewController new];
    [UIApplication sharedApplication].keyWindow.rootViewController=tabbarc;
    tabbarc.selectedIndex=4;
    [JRToast showWithText:@"登录成功" bottomOffset:80.f duration:1.0];
    
}
- (IBAction)Register:(id)sender {
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
}


/**
 获取验证码 按钮
 */
- (IBAction)ForgetPWD:(id)sender {
    BOOL isMatch = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[0-9]{10}"] evaluateWithObject:_AcountedField.text];
    if (!isMatch){
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"手机号不合法";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        [self time];
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"发送验证码成功";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }
}
/**
 QQ第三方登录
 resp
 resp.originalResponse
 QQ基本信息采集
 saveThirdInfo 根据这个接口判断需不需要绑定手机号
 @param sender QQLogin
 */
- (IBAction)QQLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            //NSLog(@"error=%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;

            [Def setObject:resp.iconurl forKey:@"iconurl"];
            [Def setObject:resp.uid forKey:@"uid"];
            [Def setObject:[resp.originalResponse valueForKey:@"nickname"] forKey:@"name"];

            YXtabbarViewController *tabbarc = [YXtabbarViewController new];
            [UIApplication sharedApplication].keyWindow.rootViewController=tabbarc;
            tabbarc.selectedIndex=4;
            self->hud = [MBProgressHUD showHUDAddedTo:tabbarc.view animated:YES];
            self->hud.mode = MBProgressHUDModeText;
            self->hud.label.text = @"登录成功";
            self->hud.offset = CGPointMake(0.f, 0.f);
            [self->hud hideAnimated:YES afterDelay:3.f];
        }
    }];
}
/**
 WX第三方登录
 resp
 resp.originalResponse
 WX基本信息采集
 saveThirdInfo 根据这个接口判断需不需要绑定手机号
 @param sender WeixinLogin
 */
- (IBAction)WeixinLogin:(id)sender{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            //NSLog(@"error=%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
//            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            //NSLog(@"Wechat unionid: %@", resp.unionId);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.unionGender);
//            // 第三方平台SDK源数据
//            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            [Def setObject:resp.iconurl forKey:@"iconurl"];
            [Def setObject:resp.uid forKey:@"uid"];
            [Def setObject:[resp.originalResponse valueForKey:@"nickname"] forKey:@"name"];
            
            YXtabbarViewController *tabbarc = [YXtabbarViewController new];
            [UIApplication sharedApplication].keyWindow.rootViewController=tabbarc;
            tabbarc.selectedIndex=4;
            self->hud = [MBProgressHUD showHUDAddedTo:tabbarc.view animated:YES];
            self->hud.mode = MBProgressHUDModeText;
            self->hud.label.text = @"登录成功";
            self->hud.offset = CGPointMake(0.f, 0.f);
            [self->hud hideAnimated:YES afterDelay:3.f];
            
        }
    }];
}
/**
 viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _AcountedField.delegate = self;
    _yzmfield.delegate = self;
    _YZMBTN.enabled=NO;;
}
/**
 60s倒计时 time
 */
-(void)time{
    __block int time = 60;
    __block UIButton *verifybutton =_YZMBTN;
    verifybutton.enabled = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [verifybutton setTitle:@"获取验证码" forState:UIControlStateNormal];
                verifybutton.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                verifybutton.backgroundColor = [UIColor whiteColor];
                NSString *strTime = [NSString stringWithFormat:@"(发送中%d)",time];
                [verifybutton setTitle:strTime forState:UIControlStateNormal];
                verifybutton.titleLabel.textColor = [UIColor yellowColor];
                verifybutton.titleLabel.alpha=1.0;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    BOOL isMatch = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"1[0-9]{10}"] evaluateWithObject:_AcountedField.text];
    if (isMatch) {
        _YZMBTN.enabled=YES;
    }else{
        _YZMBTN.enabled=NO;
    }
}
@end
