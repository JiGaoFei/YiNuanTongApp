//
//  ShopListChooseView.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListChooseView : UIView
/**最低价格*/
@property (nonatomic,strong) UILabel  * minPricieLab;
/**最低价格*/
@property (nonatomic,strong) UILabel  * maxPricieLab;
/**最低价格*/
@property (nonatomic,strong) UITextField  * minTextField;
/**最高价格*/
@property (nonatomic,strong) UITextField  * maxTextField;
/**销量从高到低btn*/
@property (nonatomic,strong) UIButton   * maxToMinBtn;
/**销量从低到高btn*/
@property (nonatomic,strong) UIButton  * minToMaxBtn;
/**重置btn*/
@property (nonatomic,strong) UIButton  * resetBtn;
/**完成btn*/
@property (nonatomic,strong) UIButton  * completeBtn;
/**点击btn的回调*/
@property (nonatomic,copy) void(^btnClicked)(NSInteger index);


- (instancetype)initWithFrame:(CGRect)frame;

@end
