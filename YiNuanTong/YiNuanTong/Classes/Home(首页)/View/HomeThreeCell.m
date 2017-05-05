//
//  HomeThreeCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/29.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "HomeThreeCell.h"

@implementation HomeThreeCell
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
    self.imgView  = [[UIImageView  alloc]initWithFrame:CGRectMake(15*kWidthScale, 10*kHeightScale, 120 *kPlus*kWidthScale, 152 *kPlus*kHeightScale)];
    
    [self.contentView addSubview:self.imgView];
}

@end
