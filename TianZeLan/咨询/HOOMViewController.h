//
//  HOOMViewController.h
//  TianZeLan
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScrollTabBarDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;

@end
@interface HOOMViewController : UIViewController

@property (nonatomic, weak) id  <ScrollTabBarDelegate>delegate;
@property (nonatomic, assign) NSInteger currentIndex;
@property(nonatomic,copy)NSArray *myTitleArray;

@end
