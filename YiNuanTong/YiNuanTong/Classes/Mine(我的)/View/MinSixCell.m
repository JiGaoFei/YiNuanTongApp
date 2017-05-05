//
//  MinSixCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "MinSixCell.h"

@implementation MinSixCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildrenViews];
    }
    return self;
}

// 创建子视图
- (void)setUpChildrenViews
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130 *kWidthScale, 80 *kHeightScale)];
  
    self.imageView =[[UIImageView alloc]initWithFrame:CGRectMake(30 *kWidthScale, 10 *kHeightScale, 65 *kWidthScale, 65 *kWidthScale)];
    [view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"女1"];
    [self.contentView addSubview:view];
}
@end
