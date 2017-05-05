//
//  OrderPayTypeView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayTypeView : UIView
/**支付宝支付*/
@property (nonatomic,strong) UIButton *aliPayBtn;
/**微信支付*/
@property (nonatomic,strong) UIButton *weChatPayBtn;


/**支付宝支付回调*/
@property (nonatomic,copy) void(^aliPayBtnBlook)();
/**微信支付回调*/
@property (nonatomic,copy) void(^weChatPayBtnBlook)();


- (instancetype)initWithFrame:(CGRect)frame;
@end
