//
//  djsTableViewCell.h
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface djsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagev;
@property (weak, nonatomic) IBOutlet UILabel *yuanprice;
@property (weak, nonatomic) IBOutlet UILabel *nowprice;
@property (weak, nonatomic) IBOutlet UILabel *numberlabel;
@property (weak, nonatomic) IBOutlet UILabel *guigelabel;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
