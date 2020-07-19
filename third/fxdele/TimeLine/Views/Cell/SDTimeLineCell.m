//
//  SDTimeLineCell.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"
#import "UIView+SDAutoLayout.h"
#import "SDTimeLineCellCommentView.h"
#import "SDWeiXinPhotoContainerView.h"
#import "SDTimeLineCellOperationMenu.h"
#import "LEETheme.h"
#import "bottomview.h"
#define UILABEL_LINE_SPACE 6
const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定

NSString *const kSDTimeLineCellOperationButtonClickedNotification = @"SDTimeLineCellOperationButtonClickedNotification";

@implementation SDTimeLineCell

{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
    UILabel *_timela;
    UIButton *_moreButton;
//    UIButton *_operationButton;
//    SDTimeLineCellCommentView *_commentView;
//    SDTimeLineCellOperationMenu *_operationMenu;
    //bottomview *_botview;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    _iconView = [UIImageView new];
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];

    _timela = [UILabel new];
    _timela.text=[NSString stringWithFormat:@"2018-%d-%d",arc4random_uniform(12),arc4random_uniform(30)];
    _timela.font = [UIFont systemFontOfSize:12];
    _botview = [bottomview new];
    [_botview.zanbtn addTarget:self action:@selector(zanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_botview.replybtn addTarget:self action:@selector(replyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_botview.sharebtn addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *views = @[_iconView, _nameLable,_timela, _contentLabel, _moreButton, _picContainerView,_botview];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, margin)
    .widthIs(50)
    .heightIs(50);
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _timela.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, margin)
    .heightIs(15)
    .widthIs(100);
 
    _contentLabel.sd_layout
    .leftEqualToView(_timela)
    .topSpaceToView(_timela, margin)
    .rightSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel);
    
    _botview.sd_layout
    .rightEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin)
    .heightIs(20)
    .widthIs(113);
 
    
}
- (void)setModel:(SDTimeLineCellModel *)model
{
    _model = model;
  
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLable.text = model.name;
    _contentLabel.text = model.msgContent;
    
    if (model.isSeleT) {
        if (model.isSeleT) {
            [_botview.zanbtn setBackgroundImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        }if (!model.isSeleT) {
            [_botview.zanbtn setBackgroundImage:[UIImage imageNamed:@"dzan"] forState:UIControlStateNormal];
        }
    }
    
    if (model.msgContent) {
        [self setLabelSpace:_contentLabel withValue:model.msgContent withFont:[UIFont systemFontOfSize:14]];
    }

    _picContainerView.picPathStringsArray = model.picNamesArray;
    
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);

    [self setupAutoHeightWithBottomView:_botview bottomMargin:15];
}
#pragma mark - private actions
- (void)moreButtonClicked{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}
-(void)zanButtonClicked{
    if (self.zanButtonClickedBlock) {
        self.zanButtonClickedBlock(self.indexPath);
    }
}
-(void)replyButtonClicked{
    if (self.replyButtonClickedBlock) {
        self.replyButtonClickedBlock(self.indexPath);
    }
}
-(void)shareButtonClicked{
    if (self.shareButtonClickedBlock) {
        self.shareButtonClickedBlock(self.indexPath);
    }
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}
@end

