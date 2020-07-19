//
//  allowhead.m
//  TianZeLan
//
//  Created by apple on 2018/6/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "allowhead.h"

@implementation allowhead

-(id)init{
    self=[[[NSBundle mainBundle]loadNibNamed:@"allowhead" owner:nil options:nil]firstObject];
    if (self) {
     
    }
    return self;
}
@end
