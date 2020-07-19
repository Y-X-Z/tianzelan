//
//  DJSViewController.h
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myScrollTabBarDelegatee <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;

@end
@interface DJSViewController : UIViewController

@property (nonatomic, weak) id  <myScrollTabBarDelegatee>delegate;
@property (nonatomic, assign) NSInteger currentIndex;
@property(nonatomic,copy)NSArray *myTitleArray;

@property(nonatomic,strong)NSString *headstr;


@end
