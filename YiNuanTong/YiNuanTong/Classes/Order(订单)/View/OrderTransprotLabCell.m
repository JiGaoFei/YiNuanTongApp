//
//  OrderTransprotLabCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderTransprotLabCell.h"
#import "YNTUITools.h"
@implementation OrderTransprotLabCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChildrenViews];
    }
    return  self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    UIView *bagView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
    bagView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bagView];
    // 创建titleLab
    self.titleLab = [YNTUITools createLabel:CGRectMake(5, 0, KScreenW, 20) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:17];
    [bagView addSubview:self.titleLab];
    
    [bagView addSubview:self.contentLab];

}
@end
