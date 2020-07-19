//
//  CollectViewController.h
//  TianZeLan
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myScrollTabBarDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;

@end
@interface CollectViewController : UIViewController
@property (nonatomic, assign) NSInteger currentIndex;
@property(nonatomic,copy)NSArray *myTitleArray;
@end
