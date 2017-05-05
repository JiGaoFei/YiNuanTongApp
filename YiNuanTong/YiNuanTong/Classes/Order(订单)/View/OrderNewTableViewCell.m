//
//  OrderNewTableViewCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewTableViewCell.h"
#import "YNTUITools.h"
#import "OrderNewListModel.h"
#import "UIImageView+WebCache.h"
@implementation OrderNewTableViewCell
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
    // 商品名称
    self.goodName = [YNTUITools createLabel:CGRectMake(110 *kWidthScale, 8 *kHeightScale, KScreenW - 150 *kWidthScale, 40) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16];
    self.goodName.numberOfLines = 0;
    self.goodName.text = @"凯萨散热器钢制散热器凯萨散热器钢制散热器";
    [self.contentView addSubview:self.goodName];
    
    // 图片
    self.goodImageView = [YNTUITools createImageView:CGRectMake(15 *kWidthScale,10 *kHeightScale , 70 *kWidthScale, 70 *kWidthScale) bgColor:nil imageName:@""];
    [self.contentView addSubview:self.goodImageView];
 
    // 创建商品数量
    self.shopNumberLab = [YNTUITools createLabel:CGRectMake(170 *kWidthScale, 70 *kHeightScale, 90 *kWidthScale, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    self.shopNumberLab.text = @"小计:3种99件";
    [self.contentView addSubview:self.shopNumberLab];
       // 创建订单金额
    self.orderMoneyLab = [YNTUITools createLabel:CGRectMake(KScreenW - 80 *kWidthScale, 70 *kHeightScale, 80 *kWidthScale, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    self.orderMoneyLab.text = @"9999.00";
    self.orderMoneyLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.orderMoneyLab];
    
}
- (void)setValeuWithModel:(OrderNewListModel *)model
{
    self.goodName.text = model.name;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_img]];
    if ([model.zhong_num isEqualToString:@"0"]) {
        // 如果是无属性时
           self.shopNumberLab.text = [NSString stringWithFormat:@"小计%@件",model.all_num];
    }else{
        // 有属性时
          self.shopNumberLab.text = [NSString stringWithFormat:@"小计%@种%@件",model.zhong_num,model.all_num];
    }

    self.orderMoneyLab.text = model.price;
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
