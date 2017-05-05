//
//  MinLineCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "MinLineCell.h"

@implementation MinLineCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 35)];
 
    [self.contentView addSubview:self.imgView];
}

@end
