//
//  OrderConfirmShippingCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderConfirmPayModel;
@interface OrderConfirmShippingCell : UITableViewCell

/**title*/
@property (nonatomic,strong) UILabel *titleLab;
/**选中按钮*/
@property (nonatomic,strong) UIButton *selecBtn;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValueWithModel:(OrderConfirmPayModel *)model;
@end
