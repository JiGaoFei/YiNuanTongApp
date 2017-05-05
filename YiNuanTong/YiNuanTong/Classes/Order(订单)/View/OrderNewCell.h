//
//  OrderNewCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNewCell : UITableViewCell
/**勾选按钮*/
@property (nonatomic,strong) UIButton  * selectBtn;
/**商品信息*/
@property (nonatomic,strong) UILabel  * shopNameLabel;
/**商品价格*/
@property (nonatomic,strong) UILabel  * shopPriceLabel;
/**数字*/
@property (nonatomic,strong) UILabel *numberLab;
/**勾选按钮回调事件*/
@property (nonatomic,copy) void(^selectBtnBlock)(BOOL isSelect);


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
