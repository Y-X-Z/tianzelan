//
//  SDTableViewController.m
//  TianZeLan
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SDTableViewController.h"

#import "SDTimeLineTableHeaderView.h"
#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"
#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"

#import "LEETheme.h"

#import "header.h"



#define kTimeLineTableViewCellId @"SDTimeLineCell"

static CGFloat textFieldH = 40;

@interface SDTableViewController ()<SDTimeLineCellDelegate, UITextFieldDelegate>

@end

@implementation SDTableViewController


{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    UITextField *_textField;
    CGFloat _totalKeybordHeight;
    NSIndexPath *_currentEditingIndexthPath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    
    __weak typeof(self) weakSelf = self;

    _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];

            [weakSelf.tableView reloadDataWithExistedHeightCache];
            
            [weakRefreshFooter endRefreshing];
        });
    }];

    UIView *headview=[YX_myUI createViewWithFrame:CGRectMake(0, 0, kScreenW, 200) Backgroundcolor:[UIColor whiteColor]];

    [headview addSubview:[YX_myUI createLabelWithFrame:CGRectMake(kScreenW/2-50, 5, 100, 40) Font:20 Text:@"圈子" textcolor:RGBA(219, 64, 63, 1) TextAlignment:NSTextAlignmentCenter numberOfLines:1]];
    
    UIImageView *imagev=[[UIImageView alloc]init];
    imagev.frame=CGRectMake(0, 50, kScreenW, 150);
    imagev.image=[UIImage imageNamed:@"image4"];
    [headview addSubview:imagev];
    
    self.tableView.tableHeaderView = headview;

    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
   
    // 解决在iOS11上朋友圈demo文字收折或者展开时出现cell跳动问题
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
}

- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"科比绝伦",
                            @"小脑斧",
                            @"好名都被狗起了",
                            @"巭孬",
                            @"爵士容颜"];
    
    NSArray *textArray = @[
                           @"“一带一路”和上海合作组织有着天然的联系。上合组织成员国、观察员国和对话伙伴国都位于“一带一路”沿线。2013年9月，习近平首次亮相上合峰会就指出：“上海合作组织6个成员国和5个观察员国都位于古丝绸之路沿线。",
                           @"央视网消息：2018年是中国提出“一带一路”倡议五周年，上海合作组织是“一带一路”倡议的积极支持者和践行者，是欧亚经济联盟和丝绸之路经济带对接的一个非常重要的平台。中国大力推动“一带一路”建设同各国发展战略对接，为上海合作组织各国创造更多合作机遇",
                           @"截至6月5日，已有21个省(区、市)陆续发布了2017年城镇单位就业人员平均工资数据。从已公布的数据看，随着我国供给侧结构性改革深入推进，经济发展新动能加快成长，企业生产经营环境明显改善，城镇单位就业人员平均工资也实现了稳步增长。",
                           @"今年第4号台风“艾云尼”第三次登陆 中国华南局地暴雨超400毫米中新社北京6月7日电 (记者 陈溯)中央气象台7日消息，今年第4号台风正式获得命名“艾云尼”，预计7日下午至夜间将再次登陆广东。",
                           @"针对近期有报道称“一带一路”项目增加了沿线国家的债务。商务部新闻发言人高峰今天回应称，中国从来不做凌驾于人的强买强卖，“一带一路”项目给沿线国家带去的不是负担，而是希望和发展。"
                           ];

    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }

        
        [resArr addObject:model];
    }
    return [resArr copy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        cell.delegate = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}



- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{

}


@end
