//
//  myheader.m
//  TianZeLan
//
//  Created by apple on 2018/6/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "myheader.h"
#import "header.h"

@implementation myheader

-(id)init{
    self=[[[NSBundle mainBundle]loadNibNamed:@"myheader" owner:nil options:nil]firstObject];
    if (self) {
        self.headimagev.layer.borderWidth =1;
        self.headimagev.layer.masksToBounds =YES;
        self.headimagev.layer.cornerRadius=self.headimagev.bounds.size.width*0.5;
        self.headimagev.layer.borderColor = [RGBA(236, 94, 88, 1) CGColor];
        
    
        
        
    }
    return self;
}

@end
