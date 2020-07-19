//
//  FoodsViewController.m
//  TianZeLan
//
//  Created by apple on 2018/5/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FoodsViewController.h"
#import "header.h"

static NSString *cellIdentifier = @"todayCell";

@interface FoodsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WKUIDelegate,WKNavigationDelegate>{
    
    UICollectionView *headerCollection;
    UICollectionView *NormalCollection;
    UIView *headerview;
    UIImageView *headimagev;
    NSArray *array;
    Hdtitleview *titleview;
    MHProgress *Progress;
    WKWebView* _WebView;
}
@end

@implementation FoodsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _WebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, kScreenW, kScreenH - isheight - 49 - isboheight-35)];
    _WebView.backgroundColor = [UIColor whiteColor];
    _WebView.UIDelegate = self;
    _WebView.navigationDelegate = self;
    [_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://s.click.taobao.com/BU4KzPw"]]];
    [self.view addSubview:_WebView];

}
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}
-(void)makeui{

    array=[NSArray arrayWithObjects:@"mz1",@"mz2",@"mz3",@"mz4",@"mz5",@"mz6",@"mz7",@"mz8", nil];
    
    headerview = [YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 380) Backgroundcolor:RGBA(242, 242, 242, 1)];
    
    headimagev = [YX_myUI createImageViewFrame:CGRectMake(0, 10, kScreenW, 140) imageName:@"but2"];
    UICollectionViewFlowLayout *headflow=[[UICollectionViewFlowLayout alloc] init];
    headerCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0,160,kScreenW,170)collectionViewLayout:headflow];
    headerCollection.backgroundColor=[UIColor whiteColor];
    [headerCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    headerCollection.delegate = self;
    headerCollection.dataSource = self;
    headerCollection.tag=1000;
    
    titleview=[[Hdtitleview alloc]init];
    titleview.frame = CGRectMake(0, 340, kScreenW, 40);
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc] init];
    NormalCollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0,kScreenW,self.view.frame.size.height-24)collectionViewLayout:flow];
    flow.sectionInset =UIEdgeInsetsMake(10,10, 10, 10);
    NormalCollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UINib *cellNib=[UINib nibWithNibName:@"todayCell" bundle:nil];
    flow.headerReferenceSize =CGSizeMake(kScreenW,headerview.frame.size.height);
    [NormalCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview"];
    [NormalCollection registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    NormalCollection.delegate = self;
    NormalCollection.dataSource = self;
    NormalCollection.tag=2000;
    [self.view addSubview:NormalCollection];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==1000) {
        return CGSizeMake(47, 63);
    }if (collectionView.tag==2000) {
        return CGSizeMake((kScreenW-30)/2,(kScreenW-30)*26/34);
    }
    return CGSizeMake(0,0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag==1000) {
        return UIEdgeInsetsMake((180-126)/4,(kScreenW-168)/8,0,(kScreenW-168)/8);
    }if (collectionView.tag==2000){
        return UIEdgeInsetsMake(0,10,0,10);
    }
    return UIEdgeInsetsMake(0,0,0,0);}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag==1000) {
        return (kScreenW-168)/8;
    }if (collectionView.tag==2000){
        return 10;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag==1000) {
        return 8;
    }if (collectionView.tag==2000){
        return 8;
    }
    return 0;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

/**
 collectionView
 @param indexPath 行数
 @return cell
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==1000) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        [cell.contentView addSubview:[YX_myUI createImageViewFrame:CGRectMake(0, 0, 47, 63) Image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",array[indexPath.item]]]]];
        return cell;
    }
    if (collectionView.tag==2000){
        todayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        return cell;
    }
    return 0;
}
/**
 didSelectItemAtIndexPath 点击跳转
 @param collectionView collectionView
 @param indexPath 行数
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==2000) {
        UICollectionReusableView*headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview" forIndexPath:indexPath];
        for (UIView *view in headerview.subviews) {
            [view removeFromSuperview];
        }
        
        [headerview addSubview:headimagev];
        [headerview addSubview:headerCollection];
        [headerview addSubview:titleview];
        return headerview;
    }
    return 0;
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
