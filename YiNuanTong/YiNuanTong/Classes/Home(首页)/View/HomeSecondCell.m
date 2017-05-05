//
//  HomeSecondCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/29.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "HomeSecondCell.h"

@implementation HomeSecondCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChidrenViews];
    }
    return self;
}
// 加载子视图
- (void)setUpChidrenViews
{
    self.imgView  = [[UIImageView  alloc]initWithFrame:CGRectMake(15*kWidthScale, 10*kHeightScale, 60*kWidthScale, 75*kHeightScale)];
    
    [self.contentView addSubview:self.imgView];
}

@end
