//
//  returninfoViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "returninfoViewController.h"
#import "header.h"

@interface returninfoViewController ()<UITextFieldDelegate,UITextViewDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    MBProgressHUD *hud;
    UIPageControl *pageControl;
    NSString *textstr;
    MHProgress *Progress;

}
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *commitbtn;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (strong, nonatomic) NSMutableArray * imageArray;
@property (strong, nonatomic) NSMutableArray * imageArr;
@property (nonatomic, retain) NSMutableArray * thumbnailImageArray;  //缩略图数组

@end

@implementation returninfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray=[NSMutableArray array];
    _imageArr=[NSMutableArray array];
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(kScreenW/2-60,kScreenH-30,120, 20)];
    [self.view addSubview:pageControl];
    _textfield.delegate =self;
    _textview.delegate =self;
    _commitbtn.enabled =NO;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addphoto:(id)sender {
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 3;
    picker.assetsFilter = ZYQAssetsFilterAllAssets;
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([(ZYQAsset*)evaluatedObject mediaType]==ZYQAssetMediaTypeVideo) {
            NSTimeInterval duration = [(ZYQAsset*)evaluatedObject duration];
            return duration >= 3;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    if (_imageArray.count>0) {
        [_imageArray removeAllObjects];
    }
    //[_src.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //self->_src.contentSize=CGSizeMake(assets.count*self->_src.frame.size.width, self->_src.frame.size.height);
        dispatch_async(dispatch_get_main_queue(), ^{
            self->pageControl.numberOfPages=assets.count;
        });
        for (int i=0; i<assets.count; i++) {
            ZYQAsset *asset=assets[i];
            UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(i*80+50,180,80,80)];
            imgview.contentMode=UIViewContentModeScaleAspectFill;
            imgview.clipsToBounds=YES;
            [asset setGetFullScreenImage:^(UIImage *result) {
                [self->_imageArray addObject:result];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imgview setImage:result];
                    [self.view addSubview:imgview];
                });
            } fromNetwokProgressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                NSLog(@"下载中%f",progress);
            }];
        }
    });
}
-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    hud = [MBProgressHUD showHUDAddedTo:picker.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"选取到达上限";
    hud.offset = CGPointMake(0.f, 0.f);
    [hud hideAnimated:YES afterDelay:2.f];
}
#pragma mark - UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage=floor(scrollView.contentOffset.x/scrollView.frame.size.width);;
}
- (IBAction)commit:(id)sender {
    if ([_textview.text isEqualToString:@""]) {
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入反馈内容";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }else if ([_textfield.text isEqualToString:@""]) {
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入手机号或邮箱";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        textstr = _textview.text;
        textstr = [textstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        textstr = [textstr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        textstr = [textstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if ([textstr isEqualToString:@""]) {
            hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"发表内容不能为空";
            hud.offset = CGPointMake(0.f, 0.f);
            [hud hideAnimated:YES afterDelay:2.f];
        }else{
            Progress = [[MHProgress alloc]
                        initWithType:MHPopViewTypeFullScreenWithTips
                        failedBlock:^(){
                            self->hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                            self->hud.mode = MBProgressHUDModeText;
                            self->hud.label.text = @"网络连接失败";
                            self->hud.offset = CGPointMake(0.f, 0.f);
                            [self->hud hideAnimated:YES afterDelay:2.f];
                        }];
            [Progress showLoadingView];
            [self performSelector:@selector(deleyMethod) withObject:nil afterDelay:2.0];
        }
    }
}
-(void)deleyMethod{
    [Progress closeLoadingView];
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"提交成功";
    hud.offset = CGPointMake(0.f, 0.f);
    [hud hideAnimated:YES afterDelay:2.f];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([_textfield.text isEqualToString:@""]||[_textview.text isEqualToString:@""]) {
        _commitbtn.enabled =NO;
    }else{
        _commitbtn.enabled =YES;
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    _placeholder.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([_textfield.text isEqualToString:@""]||[_textview.text isEqualToString:@""]) {
        _commitbtn.enabled =NO;
    }else{
        _commitbtn.enabled =YES;
    }
}

@end
