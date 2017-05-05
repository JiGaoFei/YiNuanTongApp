//
//  OrderNewListSectionFooterView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNewListSectionFooterView : UIView
// 创建数量lab
@property (nonatomic,strong)UILabel *goodNumLab;
// 创建价钱lab
@property (nonatomic,strong)UILabel *goodMoneyLab;
// 创建按钮
@property (nonatomic,strong)UIButton *deletOrderBtn;
// 创建再次购买按钮
@property (nonatomic,strong) UIButton *seconBuyBtn;
/**删除按钮的回调*/
@property (nonatomic,copy) void(^deletOrderBtnBloock)();
/**再次购买按钮的回调*/
@property (nonatomic,copy)  void(^secondBuyBtnBloock)();

- (instancetype)initWithFrame:(CGRect)frame;
@end
