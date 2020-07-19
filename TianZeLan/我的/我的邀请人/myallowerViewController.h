//
//  myallowerViewController.h
//  TianZeLan
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScrollTabBarDelegatee <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;

@end
@interface myallowerViewController : UIViewController


@property (nonatomic, weak) id  <ScrollTabBarDelegatee>delegate;
@property (nonatomic, assign) NSInteger currentIndex;
@property(nonatomic,copy)NSArray *myTitleArray;
@end
