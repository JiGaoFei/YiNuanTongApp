//
//  OrderTransportCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderTransportCell.h"
#import "YNTUITools.h"
@implementation OrderTransportCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //加载子视图
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    UIView *bagView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 27)];
    bagView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bagView];
    // 创建titleLab
    self.titleLab = [YNTUITools createLabel:CGRectMake(5, 7, KScreenW, 20) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    [bagView addSubview:self.titleLab];
    // 创建contentLab
        self.contentLab = [YNTUITools createLabel:CGRectMake(5, 29, KScreenW/2-5, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:nil  font:12];
    [bagView addSubview:self.contentLab];
    // 创建时间lab
        self.timeLab =[YNTUITools createLabel:CGRectMake(KScreenW- 160 - 10, 29, 160, 15) text:nil textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:nil  font:12];
    [bagView addSubview:self.timeLab];

}
@end
