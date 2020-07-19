//
//  todayCell.h
//  TianZeLan
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface todayCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headimagev;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *quanhoujia;
@property (weak, nonatomic) IBOutlet UILabel *nowpricelabel;
@property (weak, nonatomic) IBOutlet UILabel *youhuiquan;
@property (weak, nonatomic) IBOutlet UILabel *xiaoliang;
@property (weak, nonatomic) IBOutlet UIButton *selectbtn;

@end
