//
//  OrderNewDetailShipTypeView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/13.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNewDetailShipTypeView : UIView
/**免费按钮*/
@property (nonatomic,strong) UIButton *mianfeiBtn;
/**自取按钮*/
@property (nonatomic,strong) UIButton *ziquBtn;
/**免费按钮回调*/
@property (nonatomic,copy) void(^mianfeiBtnBlook)();
/**自取按钮回调*/
@property (nonatomic,copy) void(^ziquBtnBlook)();
- (instancetype)initWithFrame:(CGRect)frame;
@end
