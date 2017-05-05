//
//  DropDownCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/19.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "DropDownCell.h"

@implementation DropDownCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建子视图
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(5 , 5 ,80 , 20 )];
    _lab.text = @"日丰";
    _lab.textAlignment = NSTextAlignmentCenter;
    self.lab.layer.cornerRadius = 5;
    self.lab.layer.masksToBounds = YES;
    [self.contentView addSubview:_lab];
}
@end
