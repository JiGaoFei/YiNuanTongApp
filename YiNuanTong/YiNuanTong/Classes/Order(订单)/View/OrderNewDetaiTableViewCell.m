//
//  OrderNewDetaiTableViewCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetaiTableViewCell.h"
#import "YNTUITools.h"
@implementation OrderNewDetaiTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //加载子视图
        
        [self setUpChildrenViews];
        
    }
    return self;
}
// 创建子视图
- (void)setUpChildrenViews
{
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 15 *kHeightScale, KScreenW - 30 *kWidthScale, 90 *kHeightScale)];
    bagView.backgroundColor = RGBA(249, 249, 249, 1);
    
    [self.contentView addSubview:bagView];
    self.goodName = [YNTUITools createLabel:CGRectMake(12 *kWidthScale, 10 *kHeightScale, 280*kWidthScale, 36) text:@"颜色:亚光粉红:进出口方式:上进下出;口径:4分,中心距:60,柱数:30" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    self.goodName.numberOfLines = 0;
    [bagView addSubview:self.goodName];
    // 数量
    self.shopNumberLab =  [YNTUITools createLabel:CGRectMake(290 *kWidthScale, 24 *kHeightScale, 80 *kWidthScale, 30*kHeightScale) text:@"9999件" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    [bagView addSubview:self.shopNumberLab];
    // 单价
    self.orderMoneyLab = [YNTUITools createLabel:CGRectMake(12 *kWidthScale, 50 *kHeightScale, 200, 20) text:@"99元/个" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    self.orderMoneyLab.textColor = [UIColor redColor];
    [bagView addSubview:self.orderMoneyLab];


    
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
