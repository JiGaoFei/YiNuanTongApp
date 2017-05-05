//
//  ShopBottomView.h
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopBottomView : UIView
/**价格*/
@property (nonatomic,strong) UILabel *bottomPriceLab;
/**全选按钮*/
@property (nonatomic,strong) UIButton *allSelectBtn;
/**件数*/
@property (nonatomic,strong) UILabel *allNumberLab;
/**全选按钮的回调*/
@property (nonatomic,copy) void(^allSelectBtnBloock)(NSInteger index);
/**结算按钮的回调*/
@property (nonatomic,copy) void (^payBtnBlook)();


- (instancetype)initWithFrame:(CGRect)frame;
@end
