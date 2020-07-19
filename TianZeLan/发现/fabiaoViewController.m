//
//  fabiaoViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "fabiaoViewController.h"
#import "header.h"

@interface fabiaoViewController ()<UITextViewDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    NSString *textstr;
    MHProgress *Progress;
    UIPageControl *pageControl;
    MBProgressHUD *hud;
    
}
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UILabel *Placeholder;
@property (weak, nonatomic) IBOutlet UILabel *numberstr;
@property (strong, nonatomic) NSMutableArray * imageArray;
@property (strong, nonatomic) NSMutableArray * imageArr;
@property (nonatomic, retain) NSMutableArray * thumbnailImageArray;  //缩略图数组
@end

@implementation fabiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray=[NSMutableArray array];
    _imageArr=[NSMutableArray array];
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(kScreenW/2-60,kScreenH-30,120, 20)];
    [self.view addSubview:pageControl];
    _textview.delegate = self;
    _Placeholder.userInteractionEnabled = NO;
    _numberstr.hidden=YES;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)fabu:(id)sender {
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
-(void)deleyMethod{
    [Progress closeLoadingView];
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"发布成功";
    hud.offset = CGPointMake(0.f, 0.f);
    [hud hideAnimated:YES afterDelay:2.f];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textViewDidChange:(UITextView *)textView{
    _Placeholder.hidden = YES;
    _numberstr.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
    NSString *content = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textView.text.length >= 200) {
        textView.text = [content substringToIndex:200];
        _numberstr.text = @"200/200";
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"超出字数限制";
        hud.offset = CGPointMake(0.f, 0.f);
        [hud hideAnimated:YES afterDelay:2.f];
    }
    if ([textView.text isEqualToString:@""]) {
        _Placeholder.hidden = NO;
        _numberstr.text = @"0/200";
    }
}
- (IBAction)chooseimage:(id)sender {
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
            UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(i*(kScreenW/4)+30, self->_textview.height+self->_textview.frame.origin.y, kScreenW/4, kScreenW/4)];
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
@end
