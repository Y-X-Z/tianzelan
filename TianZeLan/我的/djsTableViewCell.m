//
//  djsTableViewCell.m
//  TianZeLan
//
//  Created by apple on 2018/6/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "djsTableViewCell.h"

@implementation djsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    float domstr=100 +  (arc4random() % 101);
    float dom=(arc4random() % 101);

    NSDictionary *attribtDic =@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%.2f",domstr] attributes:attribtDic];
    _yuanprice.attributedText = attribtStr;
    _nowprice.text=[NSString stringWithFormat:@"%.2f",dom];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
