//
//  HomeFistCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/17.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "HomeFistCell.h"

@implementation HomeFistCell
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
    self.imgView  = [[UIImageView  alloc]initWithFrame:CGRectMake(15*kWidthScale, 20*kHeightScale, 77*kWidthScale, 77*kHeightScale)];
    
    [self.contentView addSubview:self.imgView];
}
@end
