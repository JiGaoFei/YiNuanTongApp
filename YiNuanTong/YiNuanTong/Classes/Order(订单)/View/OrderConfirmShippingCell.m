//
//  OrderConfirmShippingCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderConfirmShippingCell.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmPayModel.h"
@implementation OrderConfirmShippingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //加载子视图
        [self setUpChildViews];
    }
    return self;
}
// 创建子视图
- (void)setUpChildViews
{


    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 10 *kHeightScale, 90, 30 *kWidthScale)];
    [self.contentView addSubview:self.titleLab];
    self.selecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selecBtn.frame = CGRectMake( KScreenW -50 *kWidthScale, 10 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale);
    [self.selecBtn setImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selecBtn];
    
}
#pragma mark 赋值
- (void)setValueWithModel:(OrderConfirmPayModel *)model
{
    self.titleLab.text = model.name;
    if (model.isSelect) {
          [self.selecBtn setImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
    }else{
          [self.selecBtn setImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    }
    
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
