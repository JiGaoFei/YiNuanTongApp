//
//  GoodsDetailTitleCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/28.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeShopListDetailModel;

@interface GoodsDetailTitleCell : UITableViewCell
/**商品名*/
@property (nonatomic,strong) UILabel  * nameLab;
/**已成交数量*/
@property (nonatomic,strong) UILabel  * numberLab;
/**快递*/
@property (nonatomic,strong) UILabel  * shipLab;
/**发货地*/
@property (nonatomic,strong) UILabel  * sendAddressLab;
/**价格*/
@property (nonatomic,strong) UILabel  * priceLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithModel:(HomeShopListDetailModel *)model;
@end
