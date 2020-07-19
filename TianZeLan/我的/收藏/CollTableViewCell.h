//
//  CollTableViewCell.h
//  TianZeLan
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headimagev;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;

@end
