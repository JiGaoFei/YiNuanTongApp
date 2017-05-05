//
//  HomeMenBtnView.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/14.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "HomeMenBtnView.h"

@implementation HomeMenBtnView

-(id)initWithFrame2:(CGRect)frame title:(NSString *)title imagestr:(NSString *)imagestr {
    self = [super initWithFrame:frame];
    if(self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 22, 10, 44, 44)];
        imageView.image = [UIImage imageNamed:imagestr];
        [self addSubview:imageView];
        
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15+44, frame.size.width, 20)];
        titlelab.text = title;
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.font = [UIFont systemFontOfSize:12];
        [self addSubview:titlelab];
        
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame title:(NSString *)title imagestr:(NSString *)imagestr {
    self = [super initWithFrame:frame];
    if(self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-22, 15, 44, 44)];
        imageView.image = [UIImage imageNamed:imagestr];
        [self addSubview:imageView];
        
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15+44, frame.size.width, 20)];
        titlelab.text = title;
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.font = [UIFont systemFontOfSize:12];
        [self addSubview:titlelab];
    }
    
    return self;
}

@end
