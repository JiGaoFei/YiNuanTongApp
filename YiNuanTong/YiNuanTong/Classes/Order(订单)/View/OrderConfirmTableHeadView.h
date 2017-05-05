//
//  OrderConfirmTableHeadView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/8.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderConfirmTableHeadView : UIView
/**订单编号*/
@property (nonatomic,strong) UILabel *orderSnLab;
/**收货人*/
@property (nonatomic,strong) UILabel *customerLab;
/**address*/
@property (nonatomic,strong) UILabel *addressLab;
/**收货地址手势回调*/
@property (nonatomic,copy) void(^tapActionBlock)();

- (instancetype)initWithFrame:(CGRect)frame;
@end
