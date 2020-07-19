//
//  YX-myUI.m
//  LingYuanShengLe8
//
//  Created by 于翔 on 2017/4/13.
//  Copyright © 2017年 yx. All rights reserved.
//

#import "YX-myUI.h"

@implementation YX_myUI

+(CALayer *) addmasktobounds:(BOOL)boundsbool cornerRadius:(NSInteger)Radius BorderWidth:(NSInteger)BorderWidth{
    CALayer *layer=[CALayer layer];
    layer.masksToBounds=boundsbool;
    layer.cornerRadius=Radius;
    layer.borderWidth=BorderWidth;
    return layer;
}
/**
 创建button
 @param frame 尺寸
 @param target target description
 @param selector self
 @param image button图片
 @param imagePressed 点击图片
 @return button
 */
+(UIButton*) createButtonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImagePressed:(NSString*)imagePressed;
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage* newImage = [UIImage imageNamed:image];
    [button setImage:newImage forState:UIControlStateNormal];
    UIImage* newPressdImage = [UIImage imageNamed:imagePressed];
    [button setImage:newPressdImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton*) createButtonWithFrame:(CGRect)frame Title:(NSString*)title Target:(id)target Selector:(SEL)selector{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIButton*) createButtonWithFrame:(CGRect)frame Title:(NSString*)title  Backgroundimage:(NSString *)backgroundimage Target:(id)target Selector:(SEL)selector{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    UIImage* groundimage = [UIImage imageNamed:backgroundimage];
    [button setBackgroundImage:groundimage forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 UIImageView 创建
 @param frame 尺寸
 @param imageName 图片名字
 @return UIImageView
 */
+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}
+(UIButton*) createButtonWithFrame:(CGRect)frame Tag:(NSInteger)tag Image:(UIImage *)image{

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    button.tag=tag;
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

/**
 创建UILabel
 @param frame 尺寸
 @param font 大小
 @param labeltext label内容
 @param color 颜色
 @param textAlignment 位置
 @param numberOfLines 行数
 @return UILabel
 */
+(UILabel *) createLabelWithFrame:(CGRect)frame Font:(NSInteger)font Text:(NSString *)labeltext textcolor:(UIColor *)color TextAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    UIFont *ffont=[UIFont systemFontOfSize:font];
    label.font=ffont;
    label.text= labeltext;
    label.textColor=color;
    label.textAlignment=textAlignment;
    label.numberOfLines=numberOfLines;
    return label;
}
+(UILabel *) createLabelWithFrame:(CGRect)frame Text:(NSString *)labeltext TextAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text= labeltext;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    return label;
}

/**
 创建UIview

 @param frame 尺寸
 @param backgroundcolor 背景色
 @return UIview
 */
+(UIView *) createViewWithFrame:(CGRect)frame Backgroundcolor:(UIColor *)backgroundcolor{
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=backgroundcolor;
    return view;
}
+(UIImageView *)createImageViewFrame:(CGRect)frame Image:(UIImage *)imagE{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image=imagE;
    return imageView;
}
+(UILabel *) createLabelWithFrame:(CGRect)frame Point:(CGPoint)point Font:(NSInteger)font Text:(NSString *)labeltext textcolor:(UIColor *)color TextAlignment:(NSTextAlignment)textAlignment{

    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    UIFont *ffont=[UIFont systemFontOfSize:font];
    label.font=ffont;
    label.text= labeltext;
    label.textColor=color;
    label.textAlignment=textAlignment;
    label.center=point;
    return label;
}
@end
