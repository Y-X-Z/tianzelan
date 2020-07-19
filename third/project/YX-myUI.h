//
//  YX-myUI.h
//  LingYuanShengLe8
//
//  Created by 于翔 on 2017/4/13.
//  Copyright © 2017年 yx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "header.h"

@interface YX_myUI : NSObject
+(CALayer *) addmasktobounds:(BOOL)boundsbool cornerRadius:(NSInteger)Radius BorderWidth:(NSInteger)BorderWidth;
+(UIButton*) createButtonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImagePressed:(NSString*)imagePressed;

+(UIButton*) createButtonWithFrame:(CGRect)frame Title:(NSString*)title Target:(id)target Selector:(SEL)selector;

+(UIButton*) createButtonWithFrame:(CGRect)frame Title:(NSString*)title  Backgroundimage:(NSString *)backgroundimage Target:(id)target Selector:(SEL)selector;

+(UIButton*) createButtonWithFrame:(CGRect)frame Tag:(NSInteger)tag Image:(UIImage *)image;
+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+(UILabel *) createLabelWithFrame:(CGRect)frame Font:(NSInteger)font Text:(NSString *)labeltext textcolor:(UIColor *)color TextAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;
+(UILabel *) createLabelWithFrame:(CGRect)frame Text:(NSString *)labeltext TextAlignment:(NSTextAlignment)textAlignment;
+(UIView *) createViewWithFrame:(CGRect)frame Backgroundcolor:(UIColor *)backgroundcolor;
+(UIImageView *)createImageViewFrame:(CGRect)frame Image:(UIImage *)imagE;

+(UILabel *) createLabelWithFrame:(CGRect)frame Point:(CGPoint)point Font:(NSInteger)font Text:(NSString *)labeltext textcolor:(UIColor *)color TextAlignment:(NSTextAlignment)textAlignment;

@end
