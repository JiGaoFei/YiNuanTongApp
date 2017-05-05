//
//  OrderDetailLineCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderDetailLineCell.h"
#import "YNTUITools.h"
@implementation OrderDetailLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建titleLab
    self.titleLab = [YNTUITools createLabel:CGRectMake(5, 0, KScreenW/ 2-5, 30) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];

    
    // 创建contentLab
    self.contentLab = [YNTUITools createLabel:CGRectMake(KScreenW / 2 , 0, KScreenW / 2 -5, 30) text:nil textAlignment:NSTextAlignmentRight textColor:nil bgColor:[UIColor whiteColor] font:15];
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 5, KScreenW, 30)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgview];
    [bgview addSubview:self.titleLab];
    [bgview addSubview:self.contentLab];

    
}
@end
