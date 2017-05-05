//
//  GoodsDetailTitleCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/28.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "GoodsDetailTitleCell.h"
#import "YNTUITools.h"
#import "HomeShopListDetailModel.h"
@implementation GoodsDetailTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载子视图
        [self setUpChildrenViews];
        
    }
    return self;
}
- (void)setUpChildrenViews
{
    
    // 创建namelab
    self.nameLab = [YNTUITools createLabel:CGRectMake(34 *kPlus, 15, KScreenW - 34 *2 *kPlus, 45) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:17];
    self.nameLab.numberOfLines = 0;
 
    [self.contentView addSubview:self.nameLab];
    
    
    // 创建价格
    self.priceLab = [YNTUITools createLabel:CGRectMake(34 *kPlus, 65, KScreenW - 34 *2 *kPlus, 45) text:@"3.20" textAlignment:NSTextAlignmentLeft textColor:CGRRed bgColor:nil font:17];
    [self.contentView addSubview:self.priceLab];
    // 创建编号lab
    self.numberLab = [YNTUITools createLabel:CGRectMake(17 *kWidthScale, 134, 100*kWidthScale, 12) text:@"已成交1000件" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];

    [self.contentView addSubview:self.numberLab];
    
    // 创建价格lab
    self.shipLab= [YNTUITools createLabel:CGRectMake(120 *kWidthScale, 134,120*kWidthScale, 13) text:@"快递:包邮" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [self.contentView addSubview:self.shipLab];

    self.sendAddressLab = [YNTUITools createLabel:CGRectMake(260 *kWidthScale, 134, 130 *kWidthScale, 13) text:@"发货地:河南 郑州" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [self.contentView addSubview:self.sendAddressLab];


}
- (void)setValueWithModel:(HomeShopListDetailModel *)model
{
    // 商品名
    self.nameLab.text = model.name;
    // 已成交数量
    self.numberLab.text = [NSString stringWithFormat:@"已成交%@件",model.sale_num];
    // 价格
    self.priceLab.text = [NSString stringWithFormat:@"¥:%@",model.price];
    // 快递
    self.shipLab.text = [NSString stringWithFormat:@"配送方式:%@",model.shipping];
    // 发货地
    self.sendAddressLab.text = [NSString stringWithFormat:@"发货地:%@",model.shippadd];
}
@end
