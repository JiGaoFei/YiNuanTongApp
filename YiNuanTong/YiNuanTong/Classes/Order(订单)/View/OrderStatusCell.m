//
//  OrderStatusCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderStatusCell.h"
#import "YNTUITools.h"
@implementation OrderStatusCell
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
- (void) setUpChildrenViews
{
    // 创建title
   self.titleLab= [YNTUITools createLabel:CGRectMake(10, 5, 150, 20) text:@"订单状态" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:15];
    [self addSubview:self.titleLab]; 
    
    // 创建公司名字
    self.companyNamelLab = [YNTUITools createLabel:CGRectMake(10, 35, KScreenW - 50, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:[UIColor whiteColor] font:12];
    [self addSubview:self.companyNamelLab];
    // 创建单号
    self.orderNumberLab = [YNTUITools createLabel:CGRectMake(10, 55 ,KScreenW - 50, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:[UIColor whiteColor] font:12];
    [self addSubview:self.orderNumberLab];
  // 创建订单时间 
    self.orderTimeLab = [YNTUITools createLabel:CGRectMake(10, 75, KScreenW - 50, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:[UIColor whiteColor] font:12];
    [self addSubview:self.orderTimeLab];

}
@end
