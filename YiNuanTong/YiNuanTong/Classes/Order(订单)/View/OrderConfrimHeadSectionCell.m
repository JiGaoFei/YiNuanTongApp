//
//  OrderConfrimHeadSectionCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderConfrimHeadSectionCell.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmPayModel.h"
@implementation OrderConfrimHeadSectionCell
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
    self.picImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 10 *kHeightScale, 30*kWidthScale, 30 *kWidthScale)];
    [self.contentView addSubview:self.picImgView];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(90 *kWidthScale, 10 *kHeightScale, 90, 30 *kWidthScale)];
    [self.contentView addSubview:self.titleLab];
    
    self.selecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selecBtn.frame = CGRectMake(KScreenW - 30 *kWidthScale, 10 *kHeightScale, 20 *kWidthScale, 20 *kWidthScale);
    self.selecBtn.userInteractionEnabled = NO;
    [self.selecBtn setImage:[UIImage imageNamed:@"order_confirm_unchecked"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selecBtn];
                           
}
#pragma mark 赋值
- (void)setValueWithModel:(OrderConfirmPayModel *)model
{
    self.titleLab.text = model.name;
    if (model.isSelect) {
        [self.selecBtn setImage:[UIImage imageNamed:@"order_confirm_checked"] forState:UIControlStateNormal];
    }else{
        [self.selecBtn setImage:[UIImage imageNamed:@"order_confirm_unchecked"] forState:UIControlStateNormal];
    }
    
   
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.logo]]];
    
}
- (void)setDetailValueWithModel:(OrderConfirmPayModel *)model
{
    self.titleLab.text = model.name;
    if (model.check) {
        [self.selecBtn setImage:[UIImage imageNamed:@"order_confirm_checked"] forState:UIControlStateNormal];
    }else{
        [self.selecBtn setImage:[UIImage imageNamed:@"order_confirm_unchecked"] forState:UIControlStateNormal];
    }
    
    
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.logo]]];
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
