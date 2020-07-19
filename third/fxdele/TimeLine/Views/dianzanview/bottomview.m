//
//  bottomview.m
//  TianZeLan
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "bottomview.h"

@implementation bottomview


-(id)init{
    self=[[[NSBundle mainBundle]loadNibNamed:@"bottomview" owner:nil options:nil]firstObject];
    if (self) {
    }
    return self;
}


@end
