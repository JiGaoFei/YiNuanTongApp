//
//  OrderNewDetailTableHeadView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNewDetailTableHeadView : UIView
/**订单编号*/
@property (nonatomic,strong) UILabel *orderSnLab;
/**收货人*/
@property (nonatomic,strong) UILabel *customerLab;
/**address*/
@property (nonatomic,strong) UILabel *addressLab;
/**物流公司*/
@property (nonatomic,strong) UILabel *shippingLab;
/**物流电话*/
@property (nonatomic,strong) UIButton*shippingPhone;
/**物流单号*/
@property (nonatomic,strong) UITextView *shippingSn;
/**拨打电话按钮*/
@property (nonatomic,strong) UIButton *callBtn;
/**拨打电话按钮的回调*/
@property (nonatomic,copy) void (^callBtnBloock)();
/**收货地址手势回调*/
@property (nonatomic,copy) void(^tapActionBlock)();
/**物流拨打电话按钮的回调*/
@property (nonatomic,copy) void (^shipingcallBtnBloock)();

- (instancetype)initWithFrame:(CGRect)frame;
@end
